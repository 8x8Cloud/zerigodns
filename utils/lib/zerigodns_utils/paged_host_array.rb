class ZerigoDNSUtils::PagedHostArray
  attr_reader :query
  
  def initialize query
    @query = query
  end
  
  def each_page
    pg = 1
    while (hosts = ZerigoDNS::Host.all(query.merge(page: pg))) && hosts.count > 0
      yield hosts
      pg += 1
    end
  end
  
  def each_host
    each_page do |page|
      page.each do |host|
        yield host
      end
    end
  end
end
