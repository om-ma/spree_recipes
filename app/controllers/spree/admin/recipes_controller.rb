module Spree
  module Admin
    class RecipesController < ResourceController

      before_action :load_recipe_data, only: [:new, :edit]

      def create
        @recipe = Spree::Recipe.new(permitted_resource_params.except(:recipe_icons, :recipe_videos))
        if @recipe.save
          @recipe.create_recipe_icons(attachment: permitted_resource_params[:recipe_icons]) if permitted_resource_params[:recipe_icons]
          @recipe.recipe_videos.create(video_url: permitted_resource_params[:recipe_videos][:video_url]) if permitted_resource_params[:recipe_videos][:video_url].present?
          flash[:notice] = "Successfully created recipe."
          redirect_to admin_recipes_url
        else
          render :action => 'new'
        end
      end

      def update
        @recipe.recipe_icons.create(attachment: permitted_resource_params[:recipe_icons]) if permitted_resource_params[:recipe_icons]
        @recipe.recipe_videos.create(video_url: permitted_resource_params[:recipe_videos][:video_url]) if permitted_resource_params[:recipe_videos][:video_url].present?
        if @recipe.update(permitted_resource_params.except(:recipe_icons, :recipe_videos))
          flash[:notice] = "Successfully updated recipe."
          redirect_to request.referrer
        else
          render :action => 'edit'
        end
      end

      private

      def scope
        Spree::Recipe.friendly
      end

      def find_resource
        scope.find(params[:id])
      end

      def collection
        return @collection if @collection.present?

        params[:q] ||= {}
        @collection = scope

        @search = @collection.ransack(params[:q])
        @collection = @search.result.order(:created_at).page(params[:page]).per(params[:per_page])
      end

      def load_recipe_data
        load_recipe_taxons
        load_ingredients
        load_instructions
      end

      def load_recipe_taxons
        @recipe_taxons = []
        recipe_root_taxon = Spree::Taxon.find_by_name "Recipes"
        @recipe_taxons = recipe_root_taxon.present? ? recipe_root_taxon.descendants : []
      end

      def load_ingredients
        @ingredients = Spree::Ingredient.all
      end

      def load_instructions
        @instructions = Spree::Instruction.all
      end

    end
  end
end
