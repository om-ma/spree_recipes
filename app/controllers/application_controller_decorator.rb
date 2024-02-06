module ApplicationControllerDecorator
  extend ActiveSupport::Concern

  included do
    before_action :set_recipe_categories
  end

  private

  def set_recipe_categories
    @recipe_category = Spree::Taxon.find_by_name("Recipes")
    @recipe_categories = @recipe_category.present? ? @recipe_category&.descendants&.where(hide_from_nav: false)&.first(8) : []
  end
end

ApplicationController.include(ApplicationControllerDecorator)