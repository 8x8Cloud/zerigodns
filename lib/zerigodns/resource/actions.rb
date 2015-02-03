module ZerigoDNS::Resource::Actions
  class <<self
    ZerigoDNS::Client::ACTIONS.each do |action|
      alias_method "orig_#{action}", action
    end
  end
end
