class Name < ApplicationRecord
  has_many :page_name
  has_many :page, through: :page_name

  has_many :name_name, foreign_key: :parent_id
  has_one :name_name, foreign_key: :child_id
  has_many :children, through: :name_name, source: :child
  has_one :parent, through: :name_name, source: :parent

  belongs_to :wiki, optional: true
end
