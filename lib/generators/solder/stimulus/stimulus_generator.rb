class Solder::StimulusGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def copy_controller_template
    template "solder_controller.js.tt", Rails.root.join("app/javascript/controllers/solder_controller.js")
  end
end
