Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin, path: Spree.admin_path do
    resources :recipes do
      resources :ingredients do
        collection do
          post :update_positions
        end
      end
      resources :instructions do
        collection do
          post :update_positions
        end
      end
    end
  end

  get '/recipes', to: 'recipes/taxons#index', as: 'recipe_taxons'
  get "recipes/*id", to: 'recipes/taxons#show', as: :nested_recipe_taxons
  get "recipe/*id", to: 'recipes#show', as: :recipe_product
  get "generate_pdf/*id", to: 'recipes#generate_pdf', as: :recipe_pdf
  post 'recipe_add_to_cart/:id', to: 'recipes#add_to_cart', as: :recipe_add_to_cart

  get "products_modal/*id", to: 'recipes#display_products_modal', as: :display_recipe_products_modal
  
end
