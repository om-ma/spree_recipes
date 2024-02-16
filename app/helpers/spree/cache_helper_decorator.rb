Spree::CacheHelper.module_eval do

  def cache_key_for_recipe_wihtout_version(recipe)
    max_updated_at = (recipe&.updated_at || Date.today).to_s(:number)
    "shared/recipes/#{recipe&.id}-#{max_updated_at}"
  end

  def cache_key_for_recipes(recipes, additional_cache_key = nil)
    max_updated_at = (recipes.map(&:updated_at).max || Date.today).to_s(:number)
    recipes_cache_keys = "spree/recipes/#{recipes.map(&:id).join('-')}-#{params[:page]}-#{params[:sort_by]}-#{max_updated_at}-#{@taxon&.id}"
    (base_cache_key + [recipes_cache_keys] + [additional_cache_key]).compact.join('/')
  end

end
