$(document).on('turbolinks:load', function() {
  $('#close-recipe-products-modal').on('click', function() {
    $(".recipe-added-modal").hide();
  });

  $('#js-recipe-product-modal').on('click', function() {
    $(".recipe-added-modal").show();
  });
});
