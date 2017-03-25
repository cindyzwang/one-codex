class TaxonomySearchesController < ApplicationController
  def index
    @scientific_name = ScientificName.joins("LEFT OUTER JOIN name ON name.id = nick_names.scientific_name_id")
                            .where("lower(scientific_names.name) LIKE :query OR nick_names.name LIKE :query",
                            query: "%#{search_params[:query].downcase}%")
    render 'api/taxonomy_searches/index'
  end

  private
  def search_params
    params.require(:search).permit(:query)
  end
end
