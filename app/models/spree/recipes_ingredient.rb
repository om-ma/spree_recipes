module Spree
  class RecipesIngredient < Spree::Base
    belongs_to :ingredient
    belongs_to :recipe
  end
end
  