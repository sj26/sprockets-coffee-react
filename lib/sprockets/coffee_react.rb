require 'sprockets'
require 'coffee-react'
require 'coffee-script'

module Sprockets
  module CoffeeReact
    class Processor
      def call(data:, **)
        ::CoffeeReact.transform(data)
      end
    end

    def self.install(environment = ::Sprockets)
      environment.register_mime_type 'application/x-cjsx', extensions: ['.cjsx']
      environment.register_transformer 'application/x-cjsx', 'text/coffeescript', Processor
    end

    if defined?(::Rails)
      class Railtie < ::Rails::Railtie
        initializer "sprockets.coffee_react", after: "sprockets.environment", group: :all do |app|
          Sprockets::CoffeeReact.install(app.config.assets)
        end
      end
    end
  end
end
