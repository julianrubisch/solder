module Solder
  class Engine < ::Rails::Engine
    isolate_namespace Solder

    initializer "solder.check_caching" do |app|
      unless app.config.action_controller.perform_caching && app.config.cache_store != :null_store
        puts <<~WARN
          🧑‍🏭 Solder uses the Rails cache store to provide UI state persistence. Therefore, please make sure caching is enabled in your environment.

          To enable caching in development, run:
            rails dev:cache
        WARN

        exit false
      end
    end
  end
end
