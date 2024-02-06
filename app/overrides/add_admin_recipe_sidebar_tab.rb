Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'add_admin_recipe_sidebar_tab',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/recipes_sidebar_menu'
)
