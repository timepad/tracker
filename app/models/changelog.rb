class Changelog < ActiveRecord::Base
  belongs_to :project

  has_many :story_points

  has_many :commits

  class << self
    def parse_pull_requests_and_commits
      tags = []

      Project.all.each do |project|
        p = 1

        tags_list = Rails.configuration.github_client.tags(project.github_path,  :page => p)

        while tags_list.present?
          tags += tags_list

          p += 1

          tags_list = Rails.configuration.github_client.tags(project.github_path,  :page => p)
        end

        tags_with_date = []

        tags.each do |tag|
          tags_with_date << [tag[:name], parse_date_for(project.github_path, tag[:commit][:sha])]
        end

        tags_with_date.sort_by! { |tag| tag.last }.each_with_index do |tag, index|
          date_from = tag.last

          date_to = tags[index + 1].present? ? tags_with_date[index + 1].last : nil

          changelog = Changelog.find_or_create_by(:title => tag.first, :project_id => project.id) do |changelog|
            changelog.github_created_at = date_from.to_datetime
          end

          # parse_and_save_commits project.github_path, date_from, date_to, changelog
        end

        tags = []
      end

      pull_requests = Project.pull_requests

      StoryPoint.parse_pull_requests pull_requests

      StoryPoint.sync_with_changelogs
    end

    def parse_and_save_commits(project, date_from, date_to, changelog)
      commits = []

      p = 1

      if date_to.present?
        commits_list = Rails.configuration.github_client.commits_between project, date_from, date_to,  :page => p
      else
        commits_list = Rails.configuration.github_client.commits_before project, date_from,  :page => p
      end

      while commits_list.present?
        commits += commits_list

        p += 1

        commits_list = Rails.configuration.github_client.
          commits_before(project, date_to,  :page => p)
      end

      commits.each do |commit_params|
        Commit.parse_and_save_with commit_params, project, changelog
      end
    end

    def fetch_with(params)
      case params[:date]
      when 'month'
        changelogs = Changelog.where('github_created_at >= ?', DateTime.now - 1.month)
      when 'year'
        changelogs = Changelog.where('github_created_at >= ?', DateTime.now - 1.year)
      else
        changelogs = Changelog.all
      end

      if params[:date_from].present? && params[:date_to].present?
        changelogs = changelogs.
          where('github_created_at >= ? and github_created_at <= ?',
                DateTime.parse(params[:date_from]),
                DateTime.parse(params[:date_to])
          )
      elsif params[:date_from].present?
        changelogs.where('github_created_at >= ?', DateTime.parse(params[:date_from]))
      elsif params[:date_to].present?
        changelogs.where('github_created_at <= ?', DateTime.parse(params[:date_to]))
      end

      if params[:project].try(:[], 0).present?
        changelogs = changelogs.where(:project_id => params[:project][0])
      end

      changelogs.includes(:story_points)
    end

    private
    def parse_date_for(project, sha)
      details = Rails.configuration.github_client.git_commit project, sha

      details[:committer][:date]
    end
  end
end
