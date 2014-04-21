require 'spec_helper'

describe Admin::DashboardController do
  it { should be_kind_of AdminController }

  let(:user) { create :user }

  it { should route(:get, '/admin').to(:action => :show) }

  describe 'GET show' do
    it { expect { get :show }.to raise_error(CanCan::AccessDenied) }
  end
  
  context 'User' do
    before { sign_in_as_user }

    describe 'GET show' do
      it { expect { get :show }.to raise_error(CanCan::AccessDenied) }
    end
  end

  context 'Admin' do
    before { sign_in_as_admin }

    describe 'GET index' do
      before { get :show }

      it { should render_template :show }

      it { assigns(:users_size).should_not be_nil }

      it { assigns(:projects_size).should_not be_nil }

      it { assigns(:requests_size).should_not be_nil }

      it { assigns(:users).should_not be_nil }

      it { assigns(:projects).should_not be_nil }

      it { assigns(:requests).should_not be_nil }
    end
  end
end
