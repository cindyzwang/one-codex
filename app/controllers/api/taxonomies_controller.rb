class TaxonomiesController < ApplicationController
  def show
    @scientific_name = ScientificName.find(params[:id])
    render 'api/scientific_names/show', status: 200
  end


  private
  def taxonomy_params
    params.require(:taxonomy).permit(:name)
  end
end
