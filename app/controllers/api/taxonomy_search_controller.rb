class Api::TaxonomySearchController < ApplicationController
  def create
    if params[:query] =~ /\D+/
      search = params[:query].split()
      search.each_with_index { |el, idx| search[idx] += '\S*'}
      search_regex_sql = '^' + search.join(' ')

      @scientific_names = ScientificName
                          .joins("LEFT OUTER JOIN child_parents ON taxonomy_id = child_parents.child_id")
                          .joins("LEFT OUTER JOIN nick_names ON scientific_names.taxonomy_id = nick_names.scientific_name_id")
                          .select("taxonomy_id, child_parents.rank, scientific_names.name, child_parents.mother_id")
                          .distinct
                          .where("scientific_names.name ~* ? OR nick_names.name ~* ?", search_regex_sql, search_regex_sql)
                          .limit(25)
      render 'api/taxonomy_searches/create'
    else
      @scientific_name = ScientificName.find(params[:query])
      @rank = ChildParent.find_by(child_id: params[:query]).rank if ChildParent.find_by(child_id: params[:query])
      @parent_id = @scientific_name.parent_id
      render 'api/taxonomies/show'
    end
  end
end
