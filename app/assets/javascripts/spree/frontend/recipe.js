$(document).on('turbolinks:load', function() {
  $('#close-recipe-products-modal').on('click', function() {
    $(".recipe-added-modal").hide();
  });

  $('#js-recipe-product-modal').on('click', function() {
    $(".recipe-added-modal").show();
  });

  
});




$('.select2-selection__choice__remove').on('click', function() {
    var prevSelect = $(this).closest('td').find('select.product_picker')
    prevSelect.find('option:selected').removeAttr('selected');
    prevSelect.find('option:selected').val(null)
});