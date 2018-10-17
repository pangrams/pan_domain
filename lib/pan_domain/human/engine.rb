require 'rails'

module PanDomain
  module Human
    class Engine < Rails::Engine
      isolate_namespace PanDomain

      paths['db/seeds.rb'] = 'db/human_domain/seeds.rb'
    end
  end
end
