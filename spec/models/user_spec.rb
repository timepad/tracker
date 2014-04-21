require 'spec_helper'

describe User do
  let(:user) { create :user }
  
  describe 'Associations' do
    it { should have_many :requests }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
  end

  describe '#admin?' do
    subject { user.admin? }  

    describe 'when user is admin' do
      before { user.update_attribute 'role', 'admin' }

      it { should be_true } 
    end
  end
end
