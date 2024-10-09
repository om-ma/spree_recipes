require 'pagy/extras/array'

module Spree
  module Recipes
    class TaxonsController < Spree::StoreController
      include Spree::FrontendHelper
      include Spree::CacheHelper
      helper 'spree/products'

       def index
        @first_recipe = Spree::Recipe.first
        recipe_taxon = Spree::Taxon.find_by_name "Recipes"
        @recipe_taxons = recipe_taxon.children
        @top_eight_categories = @recipe_taxons.limit(8)
        @top_four_categories = @recipe_taxons.limit(4)
        recipe_slide_location_names = (1..4).map { |number| "recipe_#{number}" }

        @recipe_slide_locations = Spree::SlideLocation.includes(:slides).where(name: recipe_slide_location_names)
      end

      def show
        @taxon = current_store.taxons.friendly.find("recipes/#{params[:id]}")

       if params[:q].present? && params[:sort_by].present?
          recipes = @taxon.recipes.search(params[:q]).order(name: (params[:sort_by] == "name-z-a" ? :desc : :asc))
        elsif params[:q].present?
          recipes = @taxon.recipes.search(params[:q])
        elsif params[:sort_by].present? && params[:sort_by] == "name-z-a"
          recipes = @taxon.recipes.order(name: :desc)
        else
          recipes = @taxon.recipes.order(name: :asc)
        end

        if browser.device.mobile? || browser.device.tablet?
          @pagy, @recipes = pagy_array(recipes, size: Pagy::DEFAULT[:size_mobile])
        else
          @pagy, @recipes = pagy_array(recipes)
        end
      end

    end
  end
end
