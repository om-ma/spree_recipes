module Spree
  module Admin
    class RecipesController < ResourceController

      before_action :load_recipe_data, only: [:new, :edit]

      private

      def scope
        Spree::Recipe.friendly
      end

      def find_resource
        scope.find(params[:id])
      end

      def collection
        return @collection if @collection.present?

        params[:q] ||= {}
        @collection = scope

        @search = @collection.ransack(params[:q])
        @collection = @search.result.order(:created_at).page(params[:page]).per(params[:per_page])
      end

      def load_recipe_data
        load_recipe_taxons
        load_ingredients
        load_instructions
      end

      def load_recipe_taxons
        @recipe_taxons = []
        recipe_root_taxon = Spree::Taxon.find_by_name "Recipes"
        @recipe_taxons = recipe_root_taxon.present? ? recipe_root_taxon.descendants : []
      end

      def load_ingredients
        @ingredients = Spree::Ingredient.all
      end

      def load_instructions
        @instructions = Spree::Instruction.all
      end

    end
  end
end
