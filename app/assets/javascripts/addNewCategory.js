$(document).ready(function() {

  let numerator = 0;

  $('#addNewCategory').click(function() {
    numerator += 1;

    let formHtml = $('.category-form').children('.category-field').last();

    let newFieldHtml = $(formHtml).clone();

    let forLabel = newFieldHtml.find("label[for*='post_categories_attributes']")[0];

    let inputs = newFieldHtml.find("input[name*='post[categories_attributes]']")[0];

    $(forLabel).attr("for", `post_categories_attributes_${numerator}_name`);
    $(inputs).attr({
      name: `post[categories_attributes][${numerator}][name]`,
      id: `post_categories_attributes_${numerator}_name`
    });

    $('.category-form').append(newFieldHtml.html());
  });
});