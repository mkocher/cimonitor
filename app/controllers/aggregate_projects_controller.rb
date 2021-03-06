class AggregateProjectsController < ApplicationController
  before_filter :login_required, :except => [:show]
  before_filter :load_aggregate_project, :only => [:show, :edit, :update, :destroy]

  def show
    @projects = @aggregate_project.projects
    @messages = []
    render :template => 'dashboards/show', :layout => 'application'
  end

  def new
    @aggregate_project = AggregateProject.new
  end

  def create
    @aggregate_project = AggregateProject.new(params[:aggregate_project])
    if @aggregate_project.save
      flash[:notice] = 'Aggregate project was successfully created.'
      redirect_to projects_url
    else
      render :action => "new"
    end
  end

  def update
    if @aggregate_project.update_attributes(params[:project])
      flash[:notice] = 'Aggregate project was successfully updated.'
      redirect_to projects_url
    else
      render :action => "edit"
    end
  end

  def destroy
    @aggregate_project.destroy
    redirect_to projects_url
  end

  private

  def load_aggregate_project
    @aggregate_project = AggregateProject.find(params[:id])
  end

end
