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
        @recipe_taxon = current_store.taxons.friendly.find("recipes/#{params[:id]}")

        if @recipe_taxon.children.present? && (@recipe_taxon.children.count < @recipe_taxon.descendants.count)
          @recipe_taxons = @recipe_taxon.children
          @recipes = @recipe_taxon&.recipes&.present? ? @recipe_taxon.recipes.limit(6) : []
        else
          if params[:sort_by].present? && params[:sort_by] == "name-z-a"
            recipes = @recipe_taxon.recipes.order(name: :desc)
          else
            recipes = @recipe_taxon.recipes.order(name: :asc)
          end
          if recipes.present?
            if (browser.device.mobile? || browser.device.tablet?)
              @pagy, @recipes = pagy_array(recipes, size: Pagy::DEFAULT[:size_mobile])
            else
              @pagy, @recipes = pagy_array(recipes)
            end
          end
        end
      end

    end
  end
end
