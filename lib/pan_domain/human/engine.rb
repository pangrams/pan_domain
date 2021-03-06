require 'pan_domain/engine'

module PanDomain
  module Human
    class Engine < ::PanDomain::Engine
      isolate_namespace PanDomain

      paths['db/seeds.rb'] = 'db/human_domain/seeds.rb'
    end
  end
end
