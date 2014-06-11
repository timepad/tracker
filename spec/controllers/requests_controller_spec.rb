require 'spec_helper'

describe RequestsController, :type => :controller do
  let(:user) { create :user }

  let(:request) { create :request, :user_id => user.id }

  it { should route(:post, '/requests').to(:action => :create) }

  it { should route(:get, '/requests/new').to(:action => :new) }

  it { should route(:get, '/requests/1/edit').to(:action => :edit, :id => 1) }

  it { should route(:get, '/requests/1').to(:action => :show, :id => 1) }

  it { should route(:put, '/requests/1').to(:action => :update, :id => 1) }

  it { should route(:patch, '/requests/1').to(:action => :update, :id => 1) }

  it { should route(:delete, '/requests/1').to(:action => :destroy, :id => 1) }

  context 'Unpersisted user' do
    describe 'POST create' do
      before { post :create }

      it { should redirect_to new_user_session_path }
    end

    describe 'GET new' do
      before { get :new }

      it { should redirect_to new_user_session_path }
    end
    
    describe 'GET show' do
      before { get :show, :id => request }

      it { should redirect_to new_user_session_path }
    end

    describe 'GET edit' do
      before { get :edit, :id => request }

      it { should redirect_to new_user_session_path }
    end

    describe 'PUT update' do
      before { put :update, :id => request }

      it { should redirect_to new_user_session_path }
    end

    describe 'PATCH update' do
      before { patch :update, :id => request }

      it { should redirect_to new_user_session_path }
    end

    describe 'DELETE destroy' do
      before { delete :destroy, :id => request }

      it { should redirect_to new_user_session_path }
    end
  end
  
  context 'Persisted user' do
    before { sign_in user }

    describe 'POST create' do
      context 'with valid attributes' do
        before { post :create, :request => attributes_for(:request) }

        it { should redirect_to assigns(:request) }
      end

      context 'with invalid attributes' do
        before { post :create, :request => { :title => '' } }

        it { should render_template :new }
      end
    end

    describe 'GET new' do
      before { get :new }

      it { should render_template :new }

      it { expect(assigns(:request)).not_to be_nil }
    end

    describe 'GET edit' do
      before { get :edit, :id => request }

      it { should render_template :edit }

      it { expect(assigns(:request)).not_to be_nil }
    end

    describe 'GET show' do
      before { get :show, :id => request }

      it { should render_template :show }

      it { expect(assigns(:request)).not_to be_nil }
    end

    describe 'PATCH update' do
      context 'with valid attributes' do
        before { patch :update, :id => request, :request => { :title => 'Some cool stuff to implement' } }

        it { assigns(:request).title == 'Some cool stuff to implement' }

        it { should redirect_to assigns(:request) }
      end

      context 'with invalid attributes' do
        before { patch :update, :id => request, :request => { :title => '' } }

        it { should render_template :edit }
      end
    end

    describe 'DELETE destroy' do
      before { delete :destroy, :id => request }

      it { should redirect_to :requests_dashboard }
    end
  end
end
