require "rails/generators/resource_helpers"

module Administration
  module Generators
    class ResourceGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      class_option :orm, banner: "NAME", type: :string, required: true, desc: "ORM to generate the controller for"

      source_root File.expand_path("templates", __dir__)

      def create_files
        template "controller.rb", "app/controllers/admin/#{file_name}_controller.rb"
      end

      private
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
    end
  end
end
