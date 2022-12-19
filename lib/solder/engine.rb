module Solder
  def self.config
    Rails.application.config.solder
  end

  class Engine < ::Rails::Engine
    isolate_namespace Solder

    config.solder = ActiveSupport::OrderedOptions.new
    config.solder[:around_action] = ->(_controller, action) { action.call }

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

    initializer "solder.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        include Solder::ApplicationHelper
        helper Solder::Engine.helpers
      end
    end
  end
end
