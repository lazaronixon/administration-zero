require "rails/generators/active_record"

module Admin
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration

      source_root File.expand_path("templates", __dir__)

      def add_gems
        uncomment_lines "Gemfile", /"bcrypt"/
        gem "pagy", comment: "Use Pagy to add paginated results [https://github.com/ddnexus/pagy]"
        gem "ransack", comment: "Use Ransack to enable the creation of search forms for your application [https://github.com/activerecord-hackery/ransack]"
        gem "spreadsheet_architect", comment: "Spreadsheet Architect is a library that allows you to create XLSX, ODS, or CSV spreadsheets super easily [https://github.com/westonganger/spreadsheet_architect]"
      end

      def create_migrations
        migration_template "migrations/create_admin_users.rb", "#{db_migrate_path}/create_admin_users.rb"
      end

      def create_models
        directory "models/admin", "app/models/admin"
        copy_file "models/admin_user.rb", "app/models/admin_user.rb"
        copy_file "models/application_record.rb", "app/models/application_record.rb", force: true
      end

      def create_fixture_file
        copy_file "test_unit/admin_users.yml", "test/fixtures/admin_users.yml"
      end

      def create_controllers
        directory "controllers", "app/controllers"
      end

      def create_views
        directory "erb", "app/views"
      end

      def create_helpers
        directory "helpers", "app/helpers"
      end

      def create_mailers
        directory "mailers", "app/mailers"
      end

      def create_images
        directory "images", "app/assets/images"
      end

      def add_routes
        route "resource  :password_reset", namespace: :admin
        route "resources :users", namespace: :admin
        route "delete 'sign_out', to: 'sessions#destroy'", namespace: :admin
        route "post   'sign_in',  to: 'sessions#create'", namespace: :admin
        route "get    'sign_in',  to: 'sessions#new'", namespace: :admin
        route "get    '/',        to: 'home#index'", namespace: :admin
      end

      def create_test_files
        directory "test_unit/controllers", "test/controllers"
        directory "test_unit/system", "test/system"
        copy_file "test_unit/test_helper.rb", "test/test_helper.rb", force: true
        copy_file "test_unit/application_system_test_case.rb", "test/application_system_test_case.rb", force: true
      end
    end
  end
end
