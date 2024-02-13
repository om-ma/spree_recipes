module Spree
  module Admin
    class IngredientsController < ResourceController
      belongs_to 'spree/recipe', find_by: :slug
      before_action :find_ingredients
      before_action :setup_ingredient, only: :index

      private

      def find_ingredients
        @ingredients = Spree::Ingredient.pluck(:name)
      end

      def setup_ingredient
        @recipe.ingredients.build
      end
    end
  end
end
  