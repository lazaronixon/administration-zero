class Admin::ApplicationRecord < ActiveRecord::Base
  include SpreadsheetArchitect; self.abstract_class = true; self.table_name_prefix = "admin_"
end
