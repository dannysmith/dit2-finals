# Provides useful helper methods
#-------------------------------------------------------------------------------------------------------------
# Author:      Danny Smith
# Modified:    2013-11-30
#-------------------------------------------------------------------------------------------------------------

def random_string(len)
  (0...len).map{ ('a'..'z').to_a[rand(26)] }.join
end

def random_email
  "#{random_string(8)}@#{random_string(10)}.com"
end
