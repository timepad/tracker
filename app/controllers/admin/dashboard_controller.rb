class Admin::DashboardController < AdminController
  def show
    @users_size = User.all.size

    @projects_size = Project.all.size

    @requests_size = Request.all.size

    @users = User.order('created_at desc').limit(10)

    @projects = Project.order('created_at desc').limit(10)

    @requests = Request.order('created_at desc').limit(10)
  end
end
