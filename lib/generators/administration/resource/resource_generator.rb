module Administration
  module Generators
    class ResourceGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)
    end
  end
end
