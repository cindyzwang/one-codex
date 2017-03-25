class ScientificName < ApplicationRecord
  self.primary_key = :taxonomy_id
  has_many :nick_names
end
