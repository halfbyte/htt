class TrackablesController < ApplicationController
  
  before_filter :trackable_by_path, :only => [:path]
  
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  
  def index
    @trackable_root = Trackable.find_by_parent_id(nil)
  end
  
  def new
      render :partial => 'new', :locals => { :parent_id => params[:parent_id]}    
  end
  
  def create
    @trackable = Trackable.find(params[:parent_id])
    @trackable.children.create(params[:trackable])
    redirect_to path_url(:path => '') + @trackable.path
  end
  
  def path
    @trackings = @item.trackings
  end
protected
  def not_found
    render 'shared/not_found', :status => 404
  end
private
  def trackable_by_path
    path = params[:path]
    @path_items = path.split "/"
    root = Trackable.find_by_parent_id nil
    @item = @path_items.inject(root) do |item, name|
      logger.debug("#{item.name} / #{name}")
      if (child = item.children.find_by_permalink(name))
        child
      else
        raise ActiveRecord::RecordNotFound
      end
    end
    return true
  end
  
end
