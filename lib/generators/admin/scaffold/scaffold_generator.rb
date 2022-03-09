require "rails/generators/resource_helpers"

module Admin
  module Generators
    class ScaffoldGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      class_option :orm, banner: "NAME", type: :string, required: true, desc: "ORM to generate the controller for"

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      source_root File.expand_path("templates", __dir__)

      def execute_generator
        directory "erb", "app/views/admin/#{file_name.pluralize}"

        template "controller.rb", "app/controllers/admin/#{controller_file_name}_controller.rb"
        template "functional_test.rb", "test/controllers/admin/#{controller_file_name}_controller_test.rb"
        template "system_test.rb", "test/system/admin/#{file_name.pluralize}_test.rb"

        route "resources :#{file_name.pluralize}", namespace: :admin
      end

      private
        def controller_class_path
          [ "admin" ]
        end

        def singular_route_name
          "#{controller_class_path.join('_')}_#{singular_table_name}"
        end

        def plural_route_name
          "#{controller_class_path.join('_')}_#{plural_table_name}"
        end

        def model_resource_name(base_name = singular_table_name, prefix: "")
          "[#{controller_class_path.map { |name| ":" + name }.join(", ")}, #{prefix}#{base_name}]"
        end

        def permitted_params
          attachments, others = attributes_names.partition { |name| attachments?(name) }
          params = others.map { |name| ":#{name}" }
          params += attachments.map { |name| "#{name}: []" }
          params.join(", ")
        end

        def attachments?(name)
          attribute = attributes.find { |attr| attr.name == name }
          attribute&.attachments?
        end

        def fixture_name
          table_name
        end

        def attributes_string
          attributes_hash.map { |k, v| "#{k}: #{v}" }.join(", ")
        end

        def attributes_hash
          return {} if attributes_names.empty?

          attributes_names.filter_map do |name|
            if %w(password password_confirmation).include?(name) && attributes.any?(&:password_digest?)
              ["#{name}", '"secret"']
            elsif !virtual?(name)
              ["#{name}", "@#{singular_table_name}.#{name}"]
            end
          end.sort.to_h
        end

        def boolean?(name)
          attribute = attributes.find { |attr| attr.name == name }
          attribute&.type == :boolean
        end

        def virtual?(name)
          attribute = attributes.find { |attr| attr.name == name }
          attribute&.virtual?
        end
    end
  end
end
