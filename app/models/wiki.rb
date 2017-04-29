class Wiki < ApplicationRecord
  has_one :name
  has_one :page

  def to_param
    name.name
  end
end
