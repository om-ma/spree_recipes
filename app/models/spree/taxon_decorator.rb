module Spree
  module TaxonDecorator

    def self.prepended(base)
      base.has_many :recipes_taxons
      base.has_many :recipes, through: :recipes_taxons
    end

    def popular_recipes
      recipes.where.not(popularity: 0).order(popularity: :desc)
    end

    def top_four_pop_recipes
      popular_recipes.limit(4) if popular_recipes.present?
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
