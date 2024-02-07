Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'add_admin_recipe_sidebar_tab',
  insert_after: '#sidebarProduct',
  partial: 'spree/admin/shared/recipes_sidebar_menu'
)
