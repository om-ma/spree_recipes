Deface::Override.new(
  virtual_path: 'spree/shared/nav_bar',
  name: 'add_recipes_link_on_header',
  insert_after: "[data-hook='inside_nav_bar']",
  partial: 'spree/shared/recipes_nav_bar'
)
