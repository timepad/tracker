require 'spec_helper'

describe Project do
  let(:project) { create :project }

  describe 'Validations' do
    it { should validate_presence_of :github_path }

    it { should validate_uniqueness_of :github_path }
  end
end
