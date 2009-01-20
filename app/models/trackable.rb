class Trackable < ActiveRecord::Base
  acts_as_tree :order => 'name'
  has_permalink :name
  
  def path
    path = []
    path << self
    current = self
    while parent = current.parent do
      path << parent
      current = parent
    end
    path.pop
    path.reverse.map(&:permalink).join("/")
  end
  
end
