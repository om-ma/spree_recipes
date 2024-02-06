module Spree
  class Ingredient < Spree::Base
    belongs_to :variant
    has_many :recipes_ingredients
    has_many :recipes, through: :recipes_ingredients
    self.whitelisted_ransackable_attributes =  %w[name]
  end
end
