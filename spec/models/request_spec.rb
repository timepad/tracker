require 'spec_helper'

describe Request do
  let(:request) { create :request }

  describe 'Associations' do
    it { should belong_to :user }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }

    it { should validate_uniqueness_of :title }

    it { should validate_presence_of :user_id }
  end
end
