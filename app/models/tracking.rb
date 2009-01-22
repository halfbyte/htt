class Tracking < ActiveRecord::Base
  belongs_to :trackable
  attr_writer :date

  before_validation :set_date
  before_validation :calculate_hours
    
  def time=(time)
    single_time_value = time.match /\d+[:\.]{0,1}\d*/
    has_range = !!time.match(/-/)
    double_time_value = time.match(/(\d+[:\.]{0,1}\d*).*?-.*?(\d+[:\.]{0,1}\d*)/)
    if time.blank?
      self.starts_at = Time.now
      return
    elsif double_time_value
      self.starts_at = Time.parse(clean_time(double_time_value[1]))
      self.ends_at = Time.parse(clean_time(double_time_value[2]))
    elsif single_time_value
      if has_range
        self.starts_at = Time.parse(clean_time(single_time_value[0]))
      else
        self.hours = time_to_dec(single_time_value[0].strip)
      end
    else
      self.starts_at = Time.now
    end
    
  end
  
  def time
    spec = ""
    spec << "#{self.starts_at} -" unless self.starts_at.blank?
    spec << "#{self.ends_at}" unless self.ends_at.blank?
    if spec.blank?
      spec << (self.hours.to_s || "")
    end
    spec
  end
  
  
  def open?
    self.hours.nil? && !self.starts_at.blank? && self.ends_at.blank?
  end

  def date
    return nil if self.starts_at.blank?
    self.starts_at.to_date
  end
  
private
  def clean_time(time_string)
    time = time_string.gsub(/\./, ':').strip
    if !time.match(/[:.]/) && time.length <= 2
      time << ":00"
    end
    time
  end
  
  def time_to_dec(time)
    return time.to_f if (time.match /\./)
    h, m = time.split(":")
    time = h.to_f
    time += m.to_i / 60.0 if m
    time
  end

  def set_date
    if @date
      if self.starts_at
        self.starts_at = Time.local(@date.year, @date.month, @date.day, self.starts_at.hour, self.starts_at.min)
      end
      if self.ends_at
        self.ends_at = Time.local(@date.year, @date.month, @date.day, self.ends_at.hour, self.ends_at.min)
      end
    end
    return true
  end
  
  def calculate_hours
    if self.starts_at && self.ends_at
      self.hours = (self.ends_at - self.starts_at) / 3600
    end
  end
  
  
end
