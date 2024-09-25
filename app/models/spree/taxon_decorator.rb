module Spree
  module TaxonDecorator

    def self.prepended(base)
      base.has_many :recipes_taxons
      base.has_many :recipes, through: :recipes_taxons
    end

    def popular_recipes
      recipes.where.not(popularity: 0).order(popularity: :desc)
    end

    def title
      h1_title.present? ? h1_title : name
    end

    def taxon_icon
      icon.try(:attachment)
    end
  end  
end

::Spree::Taxon.prepend(Spree::TaxonDecorator)
