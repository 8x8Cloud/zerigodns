class ZerigoDNS::Host < ZerigoDNS::Client
  include ZerigoDNS::Resource
  
  base_path 'hosts'
  resource_name 'host'
  
  
  class << self
    
    # Find host record(s) by zone and hostname
    # @param [Symbol, #read] which One of :one, :first, :last, or :all.  See http://api.rubyonrails.org/v3.2.1/classes/ActiveResource/Base.html#method-c-find
    # @param [Zone, #read] zone The zone from which to find the host record.
    # @param [String, #read] hostname The hostname to find.
    # @return Host records, or an empty list if no records found.
    def find_all_by_zone_and_hostname which, zone, hostname
      fqdn = [hostname, zone.domain].select(&:present?).join('.')
      all(fqdn: fqdn, zone_id: zone.id)
    end
    
    # @return [Host] The record found, or nil.
    def find_first_by_hostname zone, hostname
      find_all_by_zone_and_hostname(zone, hostname).first
    end
    
    # Update or Create Host for a zone
    # This method will only update the _first_ record. 
    # @param [Zone, #read] zone The zone to which the host belongs
    # @param [String, #read] hostname The hostname
    # @param [String, #read] type The type of record (e.g 'CNAME')
    # @param [Fixnum, #read] ttl The TTL of the record, in seconds.
    # @param [String, #read] data The data field of the record.
    # @return [Host] The created or updated host.
    def update_or_create(zone, hostname, type, ttl, data)
      host = find_first_by_hostname(zone, hostname)
      if host
        host.update(ttl: ttl, host_type: host_type, data: data)
      else
        host = create(
          :zone_id    => zone.id, 
          :hostname   => hostname,
          :host_type  => type,
          :data       => data,
          :ttl        => ttl
        )
      end  
      host
    end
  end
end
