class Trackable < ActiveRecord::Base
  acts_as_tree :order => 'name'
  has_permalink :name
  
  has_many :trackings
  
  def self.find_or_create_by_id_and_path(id, path)
    base = Trackable.find(id)
    return base if path.blank?
    trackable = path.split("/").inject(base) do |item, name|
      child = item.children.find_by_name(name)
      if child.nil?
        child = item.children.create(:name => name)
      end
      child
    end
  end
  
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
