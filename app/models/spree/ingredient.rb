module Spree
  class Ingredient < Spree::Base

    acts_as_list scope: :recipe

    belongs_to :variant
    belongs_to :recipe

    self.whitelisted_ransackable_attributes =  %w[name]
  end
end
