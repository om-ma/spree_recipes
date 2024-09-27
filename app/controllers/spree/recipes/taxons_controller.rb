require 'pagy/extras/array'

module Spree
  module Recipes
    class TaxonsController < Spree::StoreController
      include Spree::FrontendHelper
      include Spree::CacheHelper
      helper 'spree/products'

      def index
        recipe_taxon = Spree::Taxon.find_by_name "Recipes"
        @recipe_taxons = recipe_taxon.children
        recipe_slide_location_names = (1..4).map { |number| "recipe_#{number}" }

        @recipe_slide_locations = Spree::SlideLocation.includes(:slides).where(name: recipe_slide_location_names)
      end

      def show
        recipe_taxon = Spree::Taxon.find_by_name "Recipes"
        @recipe_taxons = recipe_taxon.children
        @recipe_taxon = current_store.taxons.friendly.find("recipes/#{params[:id]}")
        @most_popular_recipes_in_category = @recipe_taxon.recipes.where.not(popularity: 0).order(popularity: :desc)

        if params[:q].present?
          recipes = @recipe_taxon.recipes.where("name ILIKE ?", "%#{params[:q]}%")
        elsif @recipe_taxon.children.present? && (@recipe_taxon.children.count < @recipe_taxon.descendants.count)
          @recipe_taxons = @recipe_taxon.children
          recipes = @recipe_taxon&.recipes&.present? ? @recipe_taxon.recipes.limit(6) : []
        end

        if recipes.present? 
          if params[:sort_by].present? && params[:sort_by] == "name-z-a"
            recipes = recipes.order(name: :desc)
          else
            recipes = recipes.order(name: :asc)
          end
        end

        if recipes.present? 
          if (browser.device.mobile? || browser.device.tablet?)
            @pagy, @recipes = pagy_array(recipes, size: Pagy::DEFAULT[:size_mobile])
          else
            @pagy, @recipes = pagy_array(recipes)
          end
        else
          recipes = []
          @pagy, @recipes = pagy_array(recipes)
        end
      end
    end
  end
end
