class NameName < ApplicationRecord
  belongs_to :child, class_name: :Name
  belongs_to :parent, class_name: :Name
end
