module Spree
  module Admin
    class RecipeVideosController < ResourceController
      belongs_to 'spree/recipe', find_by: :slug

      private

      def modle_class
        Spree::RecipeVideo
      end

    end
  end
end
  