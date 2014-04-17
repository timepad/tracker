require 'spec_helper'

describe User do
  let(:user) { create :user }

  describe 'Validations' do
    it { should validate_presence_of :name }
  end

  describe 'Respond to' do
    it { should respond_to(:admin?) }
    
    it { should respond_to(:name) }
  end

  describe '#admin?' do
    subject { user.admin? }  

    describe 'when user is admin' do
      before { user.update_attribute 'role', 'admin' }

      it { should be_true } 
    end
  end
end
