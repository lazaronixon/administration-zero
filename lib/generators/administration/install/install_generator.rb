module Administration
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)
    end
  end
end
