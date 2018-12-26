require 'rails'

module PanDomain
  class Engine < Rails::Engine
    isolate_namespace PanDomain
  end
end
