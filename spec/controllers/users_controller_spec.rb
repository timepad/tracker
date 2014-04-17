require 'spec_helper'

describe UsersController do
  let(:user) { create :user }

  it { should route(:get, '/users/1').to(:action => :show, :id => 1) }

  describe 'GET show' do
    before { get :show, :id => 1 }

    it { should redirect_to new_user_session_path }
  end

  context 'User' do
    before { sign_in user }

    describe 'GET show' do
      before { get :show, :id => user.id }

      it { should render_template :show }
    end
  end
end
