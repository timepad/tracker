require 'spec_helper'

describe Ability do
  let(:user) { create :user }

  let(:project) { create :project }

  let(:request_object) { create :request }

  describe 'User' do
    subject { Ability.new(user) }

    it { should be_able_to :edit, user }

    it { should_not be_able_to :manage, project }
  end

  describe 'Admin' do
    subject { Ability.new(user) }

    before { user.update_attribute :role, 'admin' }

    it { should be_able_to :manage, :all }

    it { should be_able_to :sync, request_object }
  end
end
