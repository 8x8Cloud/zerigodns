class Paginator
  def initialize array, klass, request
    @array = array
    @class = klass
    @request = request
  end
  
  def load_page page
    @request.last.merge!(page: page)
    replay_request
  end
  
  def method_missing mtd, *args
    @array.__send__(mtd, *args)
  end
end
