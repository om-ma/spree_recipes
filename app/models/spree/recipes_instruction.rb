module Spree
  class RecipesInstruction < Spree::Base
    belongs_to :recipe
    belongs_to :instruction
  end
end
