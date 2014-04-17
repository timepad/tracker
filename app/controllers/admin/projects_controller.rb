class Admin::ProjectsController < AdminController
  load_and_authorize_resource :param_method => :permitted_params

  def index
    @projects = Project.order('created_at desc').page params[:page]
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new permitted_params

    if @project.save
      redirect_to [:admin, @project]
    else
      render :new
    end
  end

  def update
    if @project.update_attributes permitted_params
      redirect_to [:admin, @project]
    else
      render :edit
    end
  end

  def destroy
    @project.destroy

    redirect_to admin_projects_url
  end

  private
  def permitted_params
    params.require(:project).permit(:github_url)
  end
end
