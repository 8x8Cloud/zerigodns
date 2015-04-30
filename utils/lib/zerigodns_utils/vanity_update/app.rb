module ZerigoDNSUtils::VanityUpdate
  class App
    attr_reader :finder, :writer, :mapping
    
    def initialize
      @writer = AWriter
      @finder = AllDomainsFinder.new
      
      
      puts "Zerigo Vanity Update utility."
      puts "Updates records pointed at old Zerigo nameservers to new DDoS protected nameservers."
      
      
      parser.parse!
      
      if !ZerigoDNS::config.api_key && !ZerigoDNS::config.user
        puts "ERROR:  You must specify an api key & e-mail."
        puts parser.help
        exit 1
      end
      @mapping ||= OLD_IPS
    end
    
    def parser
      @parser ||= OptionParser.new do |opts|
        opts.on("-a", '--account', 'Use all domains on account') do
          puts "Using all domains on account"
          @finder = AllDomainsFinder.new
        end
        
        opts.on("-DDOMAINS", "--domains=DOMAINS", 'Use listed domains') do |domains|
          puts "Processing domains: #{domains}"
          @finder = SomeDomainsFinder.new(domains.split(','))
        end
        
        opts.on("-kKEY", "--api-key=KEY", 'Api Key (required)') do |api_key|
          ZerigoDNS.config.api_key = api_key
        end
        
        opts.on("-uUSER", "--user=USER", 'User e-mail (required)') do |user|
          ZerigoDNS.config.user = user
        end
        
        opts.on("-mIP,CNAME", "--map-ip=IP,CNAME", 'Custom ip mapping') do |mapping|
          ip, cname = *mapping.split(',')
          @mapping ||= {}
          puts "#{ip} -> #{cname}"
          @mapping[ip] = cname
        end
      end
    end
    
    def run
      finder.each_zone do |zone|
        begin
          puts "Processing #{zone.domain}..."
          ZerigoDNSUtils::PagedHostArray.new(zone_id: zone.id).each_host do |host|
            begin
              if host.host_type == 'A' && mapping.keys.include?(host.data)
                writer.replace(host, mapping[host.data])
              end
            rescue Exception => e
              puts "error updating #{zone.domain}: #{e}"
            end
          end
        rescue Exception => e
          puts "Error updaitng zone. #{e}"
        end
      end
    end
  end
end 
