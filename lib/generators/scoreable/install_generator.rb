module Scoreable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)
      desc "copy #{Scoreable.score_term}'s migration and model files to your application."

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def copy_model
        template "score_model.rb", File.join("app", "models", "#{Scoreable.score_term}.rb")
      end

      def copy_migration
        migration_template "migration.rb", File.join("db", "migrate", "create_#{table_name}.rb")
      end

      def show
        readme "README2"
      end

      def table_name
        Scoreable.table_name
      end
    end
  end
end