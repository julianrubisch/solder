module Solder
  class << self
    def config
      Rails.application.config.solder
    end

    def configure
      yield config
    end
  end

  class Engine < ::Rails::Engine
    isolate_namespace Solder

    config.solder = ActiveSupport::OrderedOptions.new
    config.solder[:around_action] = ->(_controller, action) { action.call }

    initializer "solder.check_caching" do |app|
      next if called_by_installer?
      next if called_by_generator?

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

    private

    def called_by_installer?
      Rake.application.top_level_tasks.include? "app:template"
    rescue
      false
    end

    def called_by_generator?
      ARGV.any? { _1.include? "solder:" }
    end
  end
end
