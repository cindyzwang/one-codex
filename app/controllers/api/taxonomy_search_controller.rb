class Api::TaxonomySearchController < ApplicationController
  def create
    if params[:query] =~ /\D+/
      @scientific_names = ScientificName
                            .joins("LEFT OUTER JOIN child_parents
                                    ON taxonomy_id = child_parents.child_id")
                            .select("taxonomy_id, child_parents.rank, scientific_names.name")
                            .distinct
                            .where(["LOWER(scientific_names.name) ~ LOWER(?)", params[:query]])
                            .limit(25)
      debugger
      render 'api/taxonomy_searches/create'
    else
      @scientific_name = ScientificName.find(params[:query])
      @rank = ChildParent.find_by(child_id: params[:query]).rank if ChildParent.find_by(child_id: params[:query])
      @parent_id = @scientific_name.parent_id
      render 'api/taxonomies/show'
    end
  end
end
