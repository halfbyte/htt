require 'test_helper'

class TrackableTest < ActiveSupport::TestCase
  
  should_have_many :trackings
  
  context "path method" do
    setup do
      @root = Trackable.create(:name => 'ROOT')
      @first = @root.children.create(:name => 'first')
      @second = @first.children.create(:name => 'second')
    end
    
    should "return empty path for root" do
      assert_equal "", @root.path 
    end
    
    should "return correct paths" do
      assert_equal "first", @first.path
      assert_equal "first/second", @second.path
    end
    
  end
  
  context "find_or_create_by_id_and_path" do

    setup do
      @root = Trackable.create(:name => 'ROOT')
      @first = @root.children.create(:name => 'first')
      @second = @first.children.create(:name => 'second')
    end
    
    should "return element if path is empty" do
      trackable = Trackable.find_or_create_by_id_and_path(@first, nil)
      assert_equal @first, trackable
    end
    
    should "return element if path is existing" do
      trackable = Trackable.find_or_create_by_id_and_path(@first, 'second')
      assert_equal @second, trackable
    end
    
    should "create element if path is not existing" do
      assert_difference "Trackable.count" do
        trackable = Trackable.find_or_create_by_id_and_path(@first, 'second/third')
      end
    end

    should "create element with correct path if path is not existing" do
      trackable = Trackable.find_or_create_by_id_and_path(@first, 'second/third')
      assert_equal "first/second/third", trackable.path
    end

  end
  
end
