Deface::Override.new(
  virtual_path: 'spree/shared/_nav_bar',
  name: 'add_recipes_link_on_header',
  insert_top: "[data-hook='inside_nav_bar']",
  partial: 'spree/shared/recipes_nav_bar'
)

Deface::Override.new(
  virtual_path: 'spree/shared/_mobile_navigation',
  name: 'add_recipes_link_on_header',
  insert_top: "[data-hook='inside_mobile_nav_bar']",
  partial: 'spree/shared/recipes_mobile_nav_bar'
)
