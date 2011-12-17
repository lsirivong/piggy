// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var alerted = false;

function submit_focus(formId) {
  if (!alerted)
  {
    $("#"+formId).trigger("submit.rails");
  }
}

function test_focus(selector) {
  $(selector).first().trigger('focus');
}

function add_fields_to_edit_transaction(transaction_id, content) {
  $('#'+transaction_id).after(content);
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}
