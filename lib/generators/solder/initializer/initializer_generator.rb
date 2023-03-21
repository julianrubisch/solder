class Solder::InitializerGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def copy_controller_template
    template "solder.rb", Rails.root.join("config/initializers/solder.rb")
  end
end
