require 'spec_helper'

describe DashboardController, :type => :controller do
  let(:user) { create :user }

  it { should route(:get, '/').to(:action => :show) }

  it { should route(:get, '/dashboard/ajax_activities').to(:action => :ajax_activities) }

  it { should route(:get, '/dashboard/issues').to(:action => :issues) }

  it { should route(:get, '/dashboard/ajax_issues').to(:action => :ajax_issues) }

  it { should route(:get, '/dashboard/projects').to(:action => :projects) }

  it { should route(:get, '/dashboard/ajax_projects').to(:action => :ajax_projects) }

  it { should route(:get, '/dashboard/requests').to(:action => :requests) }

  describe 'GET show' do
    before { get :show }

    it { should redirect_to new_user_session_path }
  end

  describe 'GET ajax_activities' do
    before { get :ajax_activities }

    it { should redirect_to new_user_session_path }
  end

  describe 'GET issues' do
    before { get :issues }

    it { should redirect_to new_user_session_path }
  end

  describe 'GET ajax_issues' do
    before { get :ajax_issues }

    it { should redirect_to new_user_session_path }
  end

  describe 'GET projects' do
    before { get :projects }

    it { should redirect_to new_user_session_path }
  end

  describe 'GET ajax_projects' do
    before { get :ajax_projects }

    it { should redirect_to new_user_session_path }
  end
  
  describe 'GET requests' do
    before { get :requests }

    it { should redirect_to new_user_session_path }
  end
  
  context 'User' do
    before { sign_in_as_user }

    describe 'GET show' do
      before { get :show }

      it { should render_template :show }
    end

    describe 'GET ajax_activities as JS' do
      before { xhr :get, :ajax_activities, :format => :js }

      it { should render_template :ajax_activities }

      it { expect(assigns(:notifications)).not_to be_nil }
    end

    describe 'GET issues' do
      before { get :issues }

      it { should render_template :issues }
    end

    describe 'GET ajax_issues as JS' do
      before { xhr :get, :ajax_issues, :format => :js }

      it { should render_template :ajax_issues }

      it { expect(assigns(:issues)).not_to be_nil }
    end

    describe 'GET projects' do
      before { get :projects }

      it { should render_template :projects }
    end

    describe 'GET ajax_projects as JS' do
      before { xhr :get, :ajax_projects, :format => :js }

      it { should render_template :ajax_projects }

      it { expect(assigns(:projects)).not_to be_nil }
    end

    describe 'GET requests' do
      before { get :requests }

      it { should render_template :requests }

      it { expect(assigns(:requests)).not_to be_nil }
    end
  end
end
