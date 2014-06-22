require 'spec_helper'

describe Admin::StoryPointsController, :type => :controller do
  it { should be_kind_of AdminController }

  let(:user) { create :user }

  let(:story_point) { create :story_point }

  it { should route(:get, '/admin/story_points').to(:action => :index) }

  it { should route(:get, '/admin/story_points/users').to(:action => :users) }

  it { should route(:get, '/admin/story_points/sync').to(:action => :sync) }

  context 'Unpersisted user' do
    it { expect { get :index }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :users }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :sync }.to raise_error(CanCan::AccessDenied) }
  end

  context 'Persisted user' do
    before { sign_in_as_user }

    it { expect { get :index }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :users }.to raise_error(CanCan::AccessDenied) }

    it { expect { get :sync }.to raise_error(CanCan::AccessDenied) }
  end

  context 'Admin' do
    before { sign_in_as_admin }

    describe 'GET index' do
      before { get :index }

      it { should render_template :index }

      it { expect(assigns(:story_points)).not_to be_nil }
    end

    describe 'GET users' do
      before { get :users }

      it { should render_template :users }

      it { expect(assigns(:story_points)).not_to be_nil }
    end
  end
end
