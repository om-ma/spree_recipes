module Spree
  class RecipesTaxon < Spree::Base
    belongs_to :taxon
    belongs_to :recipe
  end
end
  