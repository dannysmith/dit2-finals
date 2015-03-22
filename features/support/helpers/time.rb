# Overrides the Time cless to provide useful methods
#-------------------------------------------------------------------------------------------------------------
# Author:      Danny Smith
# Modified:    2013-10-29
#-------------------------------------------------------------------------------------------------------------

require 'date'

class Time
  def self.time_now_plus_one_minute
    Time.mktime(Time.now.year, Time.now.month, Time.now.day, Time.now.hour, Time.now.min, Time.now.sec + 5).strftime("%H:%M:%S")
  end

  def self.date_now_year_month_date
    Time.now.strftime("%Y-%m-%d")
  end

  def self.date_one_day_from_now
    Time.mktime(Time.now.year, Time.now.month, Time.now.day + 1.to_i).strftime("%Y-%m-%d")
  end
end
