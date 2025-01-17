require "rails/generators/active_record"

module Admin
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration

      source_root File.expand_path("templates", __dir__)

      def add_field_error_proc
        field_error_proc_code = <<~RUBY
          # Provides an HTML generator for displaying errors that come from Active Model
          config.action_view.field_error_proc = Proc.new do |html_tag, instance|
            raw Nokogiri::HTML.fragment(html_tag).child.add_class("is-invalid")
          end
        RUBY

        environment field_error_proc_code
      end

      def add_gems
        uncomment_lines "Gemfile", /"bcrypt"/
        gem "pagy", comment: "Use Pagy to add paginated results [https://github.com/ddnexus/pagy]"
        gem "ransack", comment: "Use Ransack to enable the creation of search forms for your application [https://github.com/activerecord-hackery/ransack]"
        gem "spreadsheet_architect", comment: "Spreadsheet Architect is a library that allows you to create XLSX, ODS, or CSV spreadsheets super easily [https://github.com/westonganger/spreadsheet_architect]"
      end

      def create_db_files
        copy_file "seeds.rb", "db/seeds.rb", force: true
        migration_template "migrations/create_admin_users.rb", "#{db_migrate_path}/create_admin_users.rb"
      end

      def create_models
        directory "models/admin", "app/models/admin"
        copy_file "models/application_record.rb", "app/models/application_record.rb", force: true
      end

      def create_fixture_file
        copy_file "test_unit/admin_users.yml", "test/fixtures/admin/users.yml"
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
        copy_file "test_unit/test_helper.rb", "test/test_helper.rb", force: true
      end
    end
  end
end
