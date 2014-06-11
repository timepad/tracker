require 'spec_helper'

describe StoryPoint do
  let(:story_point) { create :story_point }

  describe 'Associations' do
    it { should belong_to :project }
  end

  describe 'Validations' do
    it { should validate_presence_of :user_github_login }

    it { should validate_presence_of :github_html_url }
  end
end
