# Provides a method for cleaning up hashes returned by SOAP requests
#-------------------------------------------------------------------------------------------------------------
# Author:      Danny Smith
# Modified:    2013-10-29
#
#   This method recursively parses hashes and cleans them up. It is mainly intended for use with the Savon (http://savonrb.com/) gem.
#   Calling .parse_soap_hash on a hash like:
#
#       {:balance=>"10",
#         :exchange_rate=>"1.000000",
#         :response_type=>"ACCEPT",
#         :customer_data=>
#           {:item=>
#             [
#               {:key=>"prefix", :value=>"Ms."},
#               {:key=>"lastname", :value=>"Last name"},
#               {:key=>"firstname", :value=>"First name"},
#               {:key=>"iredeem_points_balance", :value=>"10"},
#             ]
#           }
#       }
#
#   Will return the following properly structured hash:
#
#       {:balance=>"10",
#         :exchange_rate=>"1.000000",
#         :response_type=>"ACCEPT",
#         :customer_data=>
#          { :prefix=>"Ms.",
#            :lastname=>"Last name",
#            :firstname=>"First name",
#            :iredeem_points_balance=>"10"
#           }
#       }
#-------------------------------------------------------------------------------------------------------------

# Allows hashes to be called with chaining eg. instead of:
#    hash[:key][:key]
# we can call
#    hash.key.key
class ::Hash
  def method_missing(symbol, *args, &block)
    return self[symbol] if key? symbol # Fast
    self.each { |k,v| return v if k.to_s.to_sym == symbol } # Slow, but allows non strings as keys.
    super.method_missing symbol
  end
  def respond_to?(symbol, *include_all)
    return true if key? symbol
    self.each { |k| return true if k.to_s.to_sym == symbol }
    super.respond_to?(symbol, *include_all)
  end
end


class Hash
  def parse_soap_hash

    to_return = {}

    self.each do |k, v|

      if k == :item
        return_hash = {}
        return_array = []
        v.each do |pair|
          begin
            if pair.is_a? Hash
              if [:key]
                return_hash.merge!({pair[:key].to_sym => pair[:value]})
              else
                return_array << pair.parse_soap_hash
              end
            elsif pair.is_a? Array
              if pair[0] == :item && pair[1].is_a?(Array)
                pair[1].each do |p|
                  return_hash.merge!({p[:key].to_sym => p[:value]})
                end
              end
            else
              return_array << pair
            end
          rescue => e
            puts "Error in parse_soap_hash: #{e}."
          end
        end

        to_return.merge!(return_hash)
        to_return.merge!({data: return_array}) unless return_array.empty?

      else # Key is not :item
        if v.is_a? Hash
          to_return.merge!(k => v.parse_soap_hash)
        else
          to_return.merge!(k => v)
        end
      end
    end
    return to_return
  end
end
