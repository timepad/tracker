require 'spec_helper'

describe Admin::RequestsController, :type => :controller do
  it { should be_kind_of AdminController }

  let(:user) { create :user }

  let(:request) { create :request }

  it { should route(:get, '/admin/requests').to(:action => :index) }

  it { should route(:post, '/admin/requests').to(:action => :create) }

  it { should route(:get, '/admin/requests/new').to(:action => :new) }

  it { should route(:get, '/admin/requests/1/edit').to(:action => :edit, :id => 1) }

  it { should route(:get, '/admin/requests/1').to(:action => :show, :id => 1) }

  it { should route(:put, '/admin/requests/1').to(:action => :update, :id => 1) }

  it { should route(:patch, '/admin/requests/1').to(:action => :update, :id => 1) }

  it { should route(:delete, '/admin/requests/1').to(:action => :destroy, :id => 1) }

  context 'Unpersisted user' do
    it { expect { get :index }.to raise_error(CanCan::AccessDenied) }

    it { expect { post :create }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :new }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :edit, :id => request }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :show, :id => request }.to raise_error(CanCan::AccessDenied) }

    it { expect { put :update, :id => request }.to raise_error(CanCan::AccessDenied) }

    it { expect { patch :update, :id => request }.to raise_error(CanCan::AccessDenied) }

    it { expect { delete :destroy, :id => request }.to raise_error(CanCan::AccessDenied) }
  end
  
  context 'Persisted user' do
    before { sign_in_as_user }

    it { expect { get :index }.to raise_error(CanCan::AccessDenied) }

    it { expect { post :create }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :new }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :edit, :id => request }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :show, :id => request }.to raise_error(CanCan::AccessDenied) }

    it { expect { put :update, :id => request }.to raise_error(CanCan::AccessDenied) }

    it { expect { patch :update, :id => request }.to raise_error(CanCan::AccessDenied) }

    it { expect { delete :destroy, :id => request }.to raise_error(CanCan::AccessDenied) }
  end

  context 'Admin' do
    before { sign_in_as_admin }

    describe 'GET index' do
      before { get :index }

      it { should render_template :index }

      it { expect(assigns(:requests)).not_to be_nil }
    end

    describe 'POST create' do
      context 'with valid attributes' do
        before { post :create, :request => attributes_for(:request) }

        it { should redirect_to [:admin, assigns(:request)] }
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

        it { should redirect_to [:admin, assigns(:request)] }
      end

      context 'with invalid attributes' do
        before { patch :update, :id => request, :request => { :title => '' } }

        it { should render_template :edit }
      end
    end

    describe 'DELETE destroy' do
      before { delete :destroy, :id => request }

      it { should redirect_to [:admin, :requests] }
    end
  end
end
