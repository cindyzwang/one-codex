class Api::TaxonomyController < ApplicationController
  def show
    @scientific_name = ScientificName.find(params[:id])
    @rank = ChildParent.find_by(child_id: params[:id]).rank if ChildParent.find_by(child_id: params[:id])
    @parent_id = @scientific_name.parent_id
    render 'api/taxonomies/show', status: 200
  end
end
