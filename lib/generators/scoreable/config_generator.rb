require 'rails/generators'

module Scoreable
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    desc "This generator creates an initializer file at config/initializers, " +
         "with the default configuration options for Scoreable."
    def add_initializer
      template "initializer.rb", "config/initializers/scoreable.rb"
    end

    def show_readme
       readme "README"
    end
  end
end
