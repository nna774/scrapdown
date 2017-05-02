class Page < ApplicationRecord
  has_many :page_name
  has_many :name, through: :page_name

  belongs_to :wiki, optional: true
end
