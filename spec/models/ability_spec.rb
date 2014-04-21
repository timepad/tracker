require 'spec_helper'

describe Ability do
  let(:user) { create :user }

  describe 'User' do
    subject { Ability.new(user) }

    it { should be_able_to :edit, user }
  end

  describe 'Admin' do
    subject { Ability.new(user) }

    before { user.update_attribute :role, 'admin' }

    it { should be_able_to(:manage, :all) }
  end
end
