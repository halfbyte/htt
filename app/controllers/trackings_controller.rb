class TrackingsController < ApplicationController
  before_filter :load_trackable
  
  def create
    @trackable.trackings.build(params[:tracking])
    if @trackable.save
      flash[:notice] = "Tracking gespeichert"
    else
      flash[:notice] = "Tracking speichern hat nicht funktioniert"
    end
    redirect_to path_path(:path => "") + @trackable.path
  end
  
private
  def load_trackable
    @trackable = Trackable.find_or_create_by_id_and_path(params[:trackable_id], params[:dynamic_path])
  end
end
