# Represents a response code and allows more expressive querying of response status.
# e.g. +response.env[:code].ok?+ as opposed to +(200..299).include?(response.status)+
class ZerigoDNS::Client::ResponseCode
  attr_reader :raw_code
  
  def initialize raw_code
    @raw_code = raw_code
  end
  
  # @return [Boolean] true if the response was OK
  def ok?
    (200..299).include?(raw_code) || raw_code == 302
  end
  
  # @return [Boolean] true if the response was not OK
  def error?
    !ok?
  end
  
  # @return [Boolean] true if response is 500 internal server error.
  def server_error?
    raw_code == 500
  end
  
  # @return [Boolean] true if response is 404
  def not_found?
    raw_code == 404
  end
end
