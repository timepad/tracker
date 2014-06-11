require 'spec_helper'

describe Request do
  let(:request) { create :request }

  describe 'Associations' do
    it { should belong_to :user }

    it { should belong_to :project }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }

    it { should validate_uniqueness_of :title }

    it { should validate_presence_of :user_id }

    it { should validate_presence_of :project_id }
  end

  describe '#synced?' do
    subject { request.synced? }  

    describe 'when request is synced' do
      before { request.github_issue_id = 1 }

      it { is_expected.to be true } 
    end

    describe 'when request is synced' do
      before { request.github_issue_id = nil }

      it { is_expected.to be false } 
    end
  end
end
