require 'test_helper'

class TrackingTest < ActiveSupport::TestCase
  
  should_belong_to :trackable
  
  context "time accessor" do
    setup do
      @root = Trackable.create(:name => "ROOT")
      @first = @root.children.create(:name => 'first')
      
    end
    
    context "writing" do
      setup do
        @basic = @first.trackings.build(:description => 'foo')
      end
      
      should "set start_time accordingly" do
        @basic.time = "8:00 -"
        assert_equal 8, @basic.starts_at.hour
      end
            
      should "set hours" do
        @basic.time = "8:00"
        assert_equal 8, @basic.hours
      end
      
      should "set hour fraction if given as minutes" do
        @basic.time = "8:30"
        assert_equal 8.5, @basic.hours
      end

      should "set hour fraction if given as fraction" do
        @basic.time = "8.50"
        assert_equal 8.5, @basic.hours
      end

      should "set hour if no minutes given" do
        @basic.time = "8"
        assert_equal 8, @basic.hours
      end

      should "set times, even if no minutes given" do
        @basic.time = "8-9"
        assert_equal 8, @basic.starts_at.hour
        assert_equal 9, @basic.ends_at.hour
      end

      
      should "set day if date is given" do
        @basic.date = Date.civil(2009, 1, 1)
        @basic.time = "8:30 - 9:30"
        @basic.valid?
        assert_equal(Time.local(2009, 1, 1, 8, 30), @basic.starts_at)
        assert_equal(Time.local(2009, 1, 1, 9, 30), @basic.ends_at)
      end

      should "calculate hours if a full range is given" do
        @basic.time = "8:30 - 11:30"
        @basic.valid?
        assert_equal(3.00, @basic.hours)        
      end
    end
    
  end
  
end
