class Name < ApplicationRecord
  has_many: :page_name
  has_many: :page, through: :page_name
end









