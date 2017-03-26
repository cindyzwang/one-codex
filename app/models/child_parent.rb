require 'pry'

class ChildParent < ApplicationRecord
  self.primary_key = :child_id

  validate :child_id, :parent_id, :rank
  after_initialize :make_ancestry

  private
  def make_ancestry
    child = ScientificName.find_by(taxonomy_id: self.child_id)
    child.parent_id = self.parent_id unless self.child_id == self.parent_id
    child.save!
  end
end
