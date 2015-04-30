module ZerigoDNSUtils::VanityUpdate
  class AllDomainsFinder
    def each_page
      pg = 1
      while (zones = ZerigoDNS::Zone.all(page: pg)) && zones.count > 0
        yield zones
        pg += 1
      end
    end
    
    def each_zone
      each_page do |page|
        page.each do |zone|
          yield zone
        end
      end
    end
  end
end
