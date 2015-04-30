require_relative 'vanity_update/all_domains_finder'
require_relative 'vanity_update/some_domains_finder'
require_relative 'vanity_update/a_writer'
require_relative 'vanity_update/app'

module ZerigoDNSUtils::VanityUpdate
  OLD_IPS = {
    '174.37.229.229' => 'b.ns.zerigo.net',
    '174.36.24.250' => 'd.ns.zerigo.net',
    '109.74.192.232' => 'c.ns.zerigo.net',
    '72.20.45.70' => 'e.ns.zerigo.net',
    '64.27.57.11' => 'a.ns.zerigo.net',
    '119.81.89.172' => 'f.ns.zerigo.net',
    "64.27.57.11"=>"a.ns.zerigo.net", 
    "72.20.45.90"=>"b.ns.zerigo.net", 
    "109.74.192.232"=>"c.ns.zerigo.net", 
    "174.36.24.250"=>"d.ns.zerigo.net", 
    "72.20.45.70"=>"e.ns.zerigo.net", 
    "119.81.89.172"=>"f.ns.zerigo.net"
  }.freeze
end
