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
      end

      def show
        @taxon = current_store.taxons.friendly.find("recipes/#{params[:id]}")

        if params[:sort_by].present? && params[:sort_by] == "name-z-a"
          recipes = @taxon.recipes.order(name: :desc)
        else
          recipes = @taxon.recipes.order(name: :asc)
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
