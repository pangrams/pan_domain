require 'pan_domain/engine'

module PanDomain
  module Country
    class Engine < ::PanDomain::Engine
      isolate_namespace PanDomain

      paths['db/seeds.rb'] = 'db/country_domain/seeds.rb'
    end
  end
end
