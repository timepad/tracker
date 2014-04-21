require 'spec_helper'

describe DashboardController do
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

    describe 'GET ajax_activities' do
      before { get :ajax_activities }

      it { should render_template :ajax_activities }

      it { assigns(:notifications).should_not be_nil }
    end

    describe 'GET issues' do
      before { get :issues }

      it { should render_template :issues }
    end

    describe 'GET ajax_issues' do
      before { get :ajax_issues }

      it { should render_template :ajax_issues }

      it { assigns(:issues).should_not be_nil }
    end

    describe 'GET projects' do
      before { get :projects }

      it { should render_template :projects }
    end

    describe 'GET ajax_projects' do
      before { get :ajax_projects }

      it { should render_template :ajax_projects }

      it { assigns(:projects).should_not be_nil }
    end

    describe 'GET requests' do
      before { get :requests }

      it { should render_template :requests }

      it { assigns(:requests).should_not be_nil }
    end
  end
end
