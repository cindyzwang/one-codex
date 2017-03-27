class Api::ChildrenController < ApplicationController
  def index
    @family_members = ScientificName
                        .find_by(taxonomy_id: params[:taxonomy_id])
                        .descendants
                        .joins("LEFT OUTER JOIN child_parents ON taxonomy_id = child_parents.child_id")
                        .select("taxonomy_id, child_parents.rank, scientific_names.name, child_parents.mother_id")
    render 'api/family/index'
  end
end
