module Spree
  module TaxonDecorator

    def self.prepended(base)
      base.has_many :recipes_taxons
      base.has_many :recipes, through: :recipes_taxons
    end

  end  
end

::Spree::Taxon.prepend(Spree::TaxonDecorator)
