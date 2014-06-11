require 'spec_helper'

describe Admin::UsersController, :type => :controller do
  it { should be_kind_of AdminController }

  let(:user) { create :user }

  it { should route(:get, '/admin/users').to(:action => :index) }

  it { should route(:post, '/admin/users').to(:action => :create) }

  it { should route(:get, '/admin/users/new').to(:action => :new) }

  it { should route(:get, '/admin/users/1/edit').to(:action => :edit, :id => 1) }

  it { should route(:get, '/admin/users/1').to(:action => :show, :id => 1) }

  it { should route(:put, '/admin/users/1').to(:action => :update, :id => 1) }

  it { should route(:patch, '/admin/users/1').to(:action => :update, :id => 1) }

  it { should route(:delete, '/admin/users/1').to(:action => :destroy, :id => 1) }

  context 'Unpersisted user' do
    it { expect { get :index }.to raise_error(CanCan::AccessDenied) }

    it { expect { post :create }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :new }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :edit, :id => user }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :show, :id => user }.to raise_error(CanCan::AccessDenied) }

    it { expect { put :update, :id => user }.to raise_error(CanCan::AccessDenied) }

    it { expect { patch :update, :id => user }.to raise_error(CanCan::AccessDenied) }

    it { expect { delete :destroy, :id => user }.to raise_error(CanCan::AccessDenied) }
  end
  
  context 'Persisted user' do
    before { sign_in_as_user }

    it { expect { get :index }.to raise_error(CanCan::AccessDenied) }

    it { expect { post :create }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :new }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :edit, :id => user }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :show, :id => user }.to raise_error(CanCan::AccessDenied) }

    it { expect { put :update, :id => user }.to raise_error(CanCan::AccessDenied) }

    it { expect { patch :update, :id => user }.to raise_error(CanCan::AccessDenied) }

    it { expect { delete :destroy, :id => user }.to raise_error(CanCan::AccessDenied) }
  end

  context 'Admin' do
    before { sign_in_as_admin }

    describe 'GET index' do
      before { get :index }

      it { should render_template :index }

      it { expect(assigns(:users)).not_to be_nil }
    end

    describe 'POST create' do
      context 'with valid attributes' do
        before { post :create, :user => attributes_for(:user) }

        it { should redirect_to [:admin, assigns(:user)] }
      end

      context 'with invalid attributes' do
        before { post :create, :user => { :email => '' } }

        it { should render_template :new }
      end
    end

    describe 'GET new' do
      before { get :new }

      it { should render_template :new }

      it { expect(assigns(:user)).not_to be_nil }
    end

    describe 'GET edit' do
      before { get :edit, :id => user }

      it { should render_template :edit }

      it { expect(assigns(:user)).not_to be_nil }
    end

    describe 'GET show' do
      before { get :show, :id => user }

      it { should render_template :show }

      it { expect(assigns(:user)).not_to be_nil }
    end

    describe 'PATCH update' do
      context 'with valid attributes' do
        before { patch :update, :id => user, :user => { :email => 'some@email.com' } }

        it { assigns(:user).email == 'some@email.com' }

        it { should redirect_to [:admin, assigns(:user)] }
      end

      context 'with invalid attributes' do
        before { patch :update, :id => user, :user => { :email => '' } }

        it { should render_template :edit }
      end
    end

    describe 'DELETE destroy' do
      before { delete :destroy, :id => user }

      it { should redirect_to [:admin, :users] }
    end
  end
end
