Spree::FrontendHelper.class_eval do

 def recipe_taxons_tree(root_taxon, current_taxon, max_level = 3)
  return '' if max_level < 1

  if max_level == 3 && root_taxon.leaf?
    root_taxon = root_taxon.parent
  end
  selected_parent_taxon_name = params["id"]
  show_klass = (root_taxon.children.where(hide_from_nav: false).pluck("permalink").include?(selected_parent_taxon_name) && root_taxon.parent.present?) ? 'show' : ''
  
  parent_klass = (root_taxon.children.where(hide_from_nav: false).present? && ((root_taxon&.parent&.name == "Recipes") || (root_taxon == current_taxon))) ? 'sidebar-sub-categories' : "dropdown-menu sub-child-manu-js #{show_klass}"

  content_tag :ul, class: parent_klass do
    taxons = root_taxon.children.where(hide_from_nav: false).map do |taxon|
      taxon_permalink = taxon.permalink
      selected_taxon_klass = selected_parent_taxon_name == taxon_permalink ? 'active-tab' : ''

      content_tag :li do
        css_class = taxon.children.present? ? 'dropdown-toggle tab-width border-0 p-0' : 'border-0 p-0'

        link_to(taxon.name, nested_recipe_taxons_path(taxon.permalink.sub("recipes/", "")), data: { turbolinks: false }, 'aria-label': 'Category ' + taxon.name, class: selected_taxon_klass) +
        (taxon.children.any? ?
          content_tag(:button, 'Toggle me', type: 'button', class: 'dropdown-toggle', data: { toggle: 'dropdown' }) +
          content_tag(:ul, class: 'dropdown-menu') do
            safe_join(taxon.children.map do |sub_taxon|
              sub_taxon_permalink = sub_taxon.permalink
              content_tag(:li) do
                link_to(sub_taxon.name, nested_recipe_taxons_path(sub_taxon_permalink.sub("recipes/", "")), data: { turbolinks: false }, 'aria-label': 'Subcategory ' + sub_taxon.name)
              end
            end, "\n")
          end
        : '')
      end
    end
    safe_join(taxons, "\n")
  end
end

	def spree_recipe_breadcrumbs(taxon, _separator = '', product = nil)
    return '' if current_page?('/') || taxon.nil?

    # breadcrumbs for root
    crumbs = [content_tag(:li, content_tag(
      :a, content_tag(
        :span, Spree.t(:home), itemprop: 'name'
      ) << content_tag(:meta, nil, itemprop: 'position', content: '0'), itemprop: 'url', href: recipe_taxons_path
    ) << content_tag(:span, nil, itemprop: 'item', itemscope: 'itemscope', itemtype: 'https://schema.org/Thing', itemid: recipe_taxons_path), itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'breadcrumb-item')]

    if taxon
      ancestors = taxon.ancestors.where.not(parent_id: nil)

      # breadcrumbs for ancestor taxons
      crumbs << ancestors.each_with_index.map do |ancestor, index|
        content_tag(:li, content_tag(
          :a, content_tag(
            :span, ancestor.name, itemprop: 'name'
          ) << content_tag(:meta, nil, itemprop: 'position', content: index + 1), itemprop: 'url', href: nested_recipe_taxons_path(ancestor.permalink.sub("recipes/", ""), params: permitted_product_params)
        ) << content_tag(:span, nil, itemprop: 'item', itemscope: 'itemscope', itemtype: 'https://schema.org/Thing', itemid: nested_recipe_taxons_path(ancestor.permalink.sub("recipes/", ""), params: permitted_product_params)), itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'breadcrumb-item')
      end

      # breadcrumbs for current taxon
      if product
        # Agar product exist karta hai, taxon clickable ho ga
        crumbs << content_tag(:li, content_tag(
          :a, content_tag(
            :span, taxon.name, itemprop: 'name'
          ) << content_tag(:meta, nil, itemprop: 'position', content: ancestors.size + 1), itemprop: 'url', href: nested_recipe_taxons_path(taxon.permalink.sub("recipes/", ""), params: permitted_product_params)
        ) << content_tag(:span, nil, itemprop: 'item', itemscope: 'itemscope', itemtype: 'https://schema.org/Thing', itemid: nested_recipe_taxons_path(taxon.permalink.sub("recipes/", ""), params: permitted_product_params)), itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'breadcrumb-item')
      else
        # Agar sirf taxon hai, link ke bagair show hoga
        crumbs << content_tag(:li, content_tag(
          :span, content_tag(
            :span, taxon.name, itemprop: 'name'
          ) << content_tag(:meta, nil, itemprop: 'position', content: ancestors.size + 1)
        ), itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'breadcrumb-item')
      end

      # breadcrumbs for product agar exist karta hai
      if product
        crumbs << content_tag(:li, content_tag(
          :span, content_tag(
            :span, product.name, itemprop: 'name'
          ) << content_tag(:meta, nil, itemprop: 'position', content: ancestors.size + 2), itemprop: 'url', href: recipe_product_path(product, taxon_id: taxon&.id)
        ) << content_tag(:span, nil, itemprop: 'item', itemscope: 'itemscope', itemtype: 'https://schema.org/Thing', itemid: recipe_product_path(product, taxon_id: taxon&.id)), itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement', class: 'breadcrumb-item')
      end
    else
      # breadcrumbs for product agar sirf PDP pe hain
      crumbs << content_tag(:li, content_tag(
        :span, Spree.t(:products), itemprop: 'item'
      ) << content_tag(:meta, nil, itemprop: 'position', content: '1'), class: 'active', itemscope: 'itemscope', itemtype: 'https://schema.org/ListItem', itemprop: 'itemListElement')
    end

    # Breadcrumb list ka final content_tag
    crumb_list = content_tag(:ol, raw(crumbs.flatten.map(&:mb_chars).join), class: 'breadcrumb', itemscope: 'itemscope', itemtype: 'https://schema.org/BreadcrumbList')
    content_tag(:nav, crumb_list, id: 'breadcrumbs', class: 'col-12 mt-1 mt-sm-3 mt-lg-4', aria: { label: Spree.t(:breadcrumbs) })
  end

  def slide(location)
    location.slides.first
  end

  def category_recipe_id(category)
    category.permalink.sub("recipes/", "")
  end

  def category_image(category)
    image_url = if category.taxon_icon.present?
                  main_app.url_for(category.taxon_icon)
                else
                  asset_path("product-thumb-1.jpg")
                end

    image_tag(image_url, alt: "#{category.name} Image", size: "160x160")
  end
end