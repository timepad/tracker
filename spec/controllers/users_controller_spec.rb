require 'spec_helper'

describe UsersController, :type => :controller do
  let(:user) { create :user }

  it { should route(:get, '/users/1').to(:action => :show, :id => 1) }

  it { should route(:get, '/users/1/edit').to(:action => :edit, :id => 1) }

  it { should route(:patch, '/users/1').to(:action => :update, :id => 1) }

  it { should route(:put, '/users/1').to(:action => :update, :id => 1) }

  describe 'GET show' do
    before { get :show, :id => user }

    it { should redirect_to new_user_session_path }
  end

  describe 'GET edit' do
    before { get :edit, :id => user }

    it { should redirect_to new_user_session_path }
  end

  describe 'PUT update' do
    before { put :update, :id => user }

    it { should redirect_to new_user_session_path }
  end

  describe 'PATCH update' do
    before { patch :update, :id => user }

    it { should redirect_to new_user_session_path }
  end

  context 'User' do
    before { sign_in user }

    describe 'GET show' do
      before { get :show, :id => user }

      it { should render_template :show }

      it { expect(assigns(:user)).not_to be_nil }
    end

    describe 'GET edit' do
      before { get :edit, :id => user }

      it { should render_template :edit }

      it { expect(assigns(:user)).not_to be_nil }
    end

    describe 'PATCH update' do
      context 'with valid attributes' do
        before { patch :update, :id => user, :user => { :email => 'some@email.com' } }

        it { assigns(:user).email == 'some@email.com' }

        it { should redirect_to assigns(:user) }
      end

      context 'with invalid attributes' do
        before { patch :update, :id => user, :user => { :email => '' } }

        it { should render_template :edit }
      end
    end
  end
end
