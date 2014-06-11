require 'spec_helper'

describe Admin::ProjectsController, :type => :controller do
  it { should be_kind_of AdminController }

  let(:user) { create :user }

  let(:project) { create :project }

  it { should route(:get, '/admin/projects').to(:action => :index) }

  it { should route(:post, '/admin/projects').to(:action => :create) }

  it { should route(:get, '/admin/projects/new').to(:action => :new) }

  it { should route(:get, '/admin/projects/1/edit').to(:action => :edit, :id => 1) }

  it { should route(:get, '/admin/projects/1').to(:action => :show, :id => 1) }

  it { should route(:put, '/admin/projects/1').to(:action => :update, :id => 1) }

  it { should route(:patch, '/admin/projects/1').to(:action => :update, :id => 1) }

  it { should route(:delete, '/admin/projects/1').to(:action => :destroy, :id => 1) }

  context 'Unpersisted user' do
    it { expect { get :index }.to raise_error(CanCan::AccessDenied) }

    it { expect { post :create }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :new }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :edit, :id => project }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :show, :id => project }.to raise_error(CanCan::AccessDenied) }

    it { expect { put :update, :id => project }.to raise_error(CanCan::AccessDenied) }

    it { expect { patch :update, :id => project }.to raise_error(CanCan::AccessDenied) }

    it { expect { delete :destroy, :id => project }.to raise_error(CanCan::AccessDenied) }
  end
  
  context 'Persisted user' do
    before { sign_in_as_user }

    it { expect { get :index }.to raise_error(CanCan::AccessDenied) }

    it { expect { post :create }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :new }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :edit, :id => project }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :show, :id => project }.to raise_error(CanCan::AccessDenied) }

    it { expect { put :update, :id => project }.to raise_error(CanCan::AccessDenied) }

    it { expect { patch :update, :id => project }.to raise_error(CanCan::AccessDenied) }

    it { expect { delete :destroy, :id => project }.to raise_error(CanCan::AccessDenied) }
  end

  context 'Admin' do
    before { sign_in_as_admin }

    describe 'GET index' do
      before { get :index }

      it { should render_template :index }

      it { expect(assigns(:projects)).not_to be_nil }
    end

    describe 'POST create' do
      context 'with valid attributes' do
        before { post :create, :project => attributes_for(:project) }

        it { should redirect_to [:admin, assigns(:project)] }
      end

      context 'with invalid attributes' do
        before { post :create, :project => { :github_path => '' } }

        it { should render_template :new }
      end
    end

    describe 'GET new' do
      before { get :new }

      it { should render_template :new }

      it { expect(assigns(:project)).not_to be_nil }
    end

    describe 'GET edit' do
      before { get :edit, :id => project }

      it { should render_template :edit }

      it { expect(assigns(:project)).not_to be_nil }
    end

    describe 'GET show' do
      before { get :show, :id => project }

      it { should render_template :show }

      it { expect(assigns(:project)).not_to be_nil }
    end

    describe 'PATCH update' do
      context 'with valid attributes' do
        before { patch :update, :id => project, :project => { :github_path => 'some/project' } }

        it { assigns(:project).github_path == 'some/project' }

        it { should redirect_to [:admin, assigns(:project)] }
      end

      context 'with invalid attributes' do
        before { patch :update, :id => project, :project => { :github_path => '' } }

        it { should render_template :edit }
      end
    end

    describe 'DELETE destroy' do
      before { delete :destroy, :id => project }

      it { should redirect_to [:admin, :projects] }
    end
  end
end
