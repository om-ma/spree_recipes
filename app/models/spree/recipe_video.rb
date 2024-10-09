module Spree
  class RecipeVideo < Spree::Base
    belongs_to :recipe, class_name: 'Spree::Recipe'
  end
end
