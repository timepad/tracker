require 'spec_helper'

describe Admin::DashboardController, :type => :controller do
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

      it { expect(assigns(:users_size)).not_to be_nil }

      it { expect(assigns(:projects_size)).not_to be_nil }

      it { expect(assigns(:requests_size)).not_to be_nil }

      it { expect(assigns(:users)).not_to be_nil }

      it { expect(assigns(:projects)).not_to be_nil }

      it { expect(assigns(:requests)).not_to be_nil }
    end
  end
end
