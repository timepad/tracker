class StoryPoint < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :user_github_login, :github_html_url

  class << self
    def parse_pull_requests pull_requests = []
      story_points = []

      pull_requests.each do |pull_request|
        (parse_pull_request_body pull_request[:body]).each do |data_for_story_point|
          title = parse_title(data_for_story_point)

          story_point_type = parse_story_point_type(data_for_story_point)
          
          title = pull_request[:title] unless title.present? && story_point_type.present?

          story_point = StoryPoint.find_or_create_by(:title => title,
            :github_html_url => pull_request[:html_url]) do |story_point|
            
            story_point.user_github_login = pull_request[:user][:login]
            
            story_point.user_github_avatar_url = pull_request[:user][:avatar_url]
            
            story_point.story_point_size = parse_size(data_for_story_point)

            story_point.github_closed_at = pull_request[:closed_at].to_datetime if pull_request[:closed_at].present?

            story_point.github_merged_at = pull_request[:merged_at].to_datetime if pull_request[:merged_at].present?
            
            story_point.story_point_type = story_point_type
          end

          if (project = Project.where(:github_path => pull_request[:base][:repo][:full_name]).first).present?
            story_point.project = project

            story_point.save
          end
        end
      end
    end

    def fetch_with params
      case params[:date]
      when 'month'
        story_points = StoryPoint.where('github_closed_at >= ?', DateTime.now - 1.month)
      when 'year'
        story_points = StoryPoint.where('github_closed_at >= ?', DateTime.now - 1.year)
      else
        story_points = StoryPoint.all
      end

      if params[:date_from].present? && params[:date_to].present?
        story_points = story_points.
          where('github_closed_at >= ? and github_closed_at <= ?',
            DateTime.parse(params[:date_from]),
            DateTime.parse(params[:date_to])
          )
      elsif params[:date_from].present?
        story_points.where('github_closed_at >= ?', DateTime.parse(params[:date_from]))
      elsif params[:date_to].present?
        story_points.where('github_closed_at <= ?', DateTime.parse(params[:date_to]))
      end

      if params[:project].try(:[], 0).present?
        story_points = story_points.where(:project_id => params[:project][0])
      end

      story_points
    end

    private
    def parse_pull_request_body string_to_parse
      (title = string_to_parse.scan(/^[0-9]*\.*\s*\[\w*\]+.*/)).present? ? title : [string_to_parse]
    end

    def parse_title string_to_parse
      /[0-9]*\.*\s*(\[\w*\])*(.*)/m.match(string_to_parse).try(:[], -1).try(:strip).to_s
    end

    def parse_size string_to_parse
      info = string_to_parse.scan(/^[0-9]*\.*\s*\[.*\]/m).first.to_s

      info.scan(/\[\w*?\]/).try(:[], 1).to_s.sub(']', '').sub('[', '')
    end

    def parse_story_point_type string_to_parse
      info = string_to_parse.scan(/^[0-9]*\.*\s*\[.*\]/m).first.to_s

      info.scan(/\[\w*?\]/).first.to_s.sub(']', '').sub('[', '')
    end
  end
end
