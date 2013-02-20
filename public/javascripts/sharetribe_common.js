function initialize_confirmation_pending_form(locale, email_in_use_message) {
	$('#mistyped_email_link').click(function() { 
		$('#password_forgotten').slideToggle('fast'); 
		$('input.email').focus();
	});
	var form_id = "#change_mistyped_email_form";
  $(form_id).validate({
     errorPlacement: function(error, element) {
       error.insertAfter(element);
     },
     rules: {
       "person[email]": {required: true, email: true, remote: "/people/check_email_availability_and_validity"}
     },
     messages: {
       "person[email]": { remote: email_in_use_message }
     },
     onkeyup: false, //Only do validations when form focus changes to avoid exessive ASI calls
     submitHandler: function(form) {
       disable_and_submit(form_id, form, "false", locale);  
     }
  });
}

/* This should be used with non-ajax forms only */
function disable_and_submit(form_id, form, ajax, locale) {
  disable_submit_button(form_id, locale);
  form.submit();
}

/* This should be used always with ajax forms */
function prepare_ajax_form(form_id, locale, rules) {
  $(form_id).ajaxForm({
    dataType: 'script',
    beforeSubmit: function() {
      $(form_id).validate({
        rules: rules
      });
      if ($(form_id).valid() == true) {
        disable_submit_button(form_id, locale);
  	  }
      return $(form_id).valid();
    }
  });
}

function disable_submit_button(form_id, locale) {
  $(form_id + ' input[type=submit]').attr('disabled', 'disabled');
	jQuery.getJSON('/javascripts/locales/' + locale + '.json', function(json) {
	  $(form_id + ' input[type=submit]').val(json.please_wait);
	});
}

function auto_resize_text_areas(class_name) {
  $('textarea.' + class_name).autosize();
}

function translate_validation_messages(locale) {
  jQuery.getJSON('/javascripts/locales/' + locale + '.json', function(json) {
    jQuery.extend(jQuery.validator.messages, {
        required: json.validation_messages.required,
        remote: json.validation_messages.remote,
        email: json.validation_messages.email,
        url: json.validation_messages.url,
        date: json.validation_messages.date,
        dateISO: json.validation_messages.dateISO,
        number: json.validation_messages.number,
        digits: json.validation_messages.digits,
        creditcard: json.validation_messages.creditcard,
        equalTo: json.validation_messages.equalTo,
        accept: json.validation_messages.accept,
        maxlength: jQuery.validator.format(json.validation_messages.maxlength),
        minlength: jQuery.validator.format(json.validation_messages.minlength),
        rangelength: jQuery.validator.format(json.validation_messages.rangelength),
        range: jQuery.validator.format(json.validation_messages.range),
        max: jQuery.validator.format(json.validation_messages.max),
        min: jQuery.validator.format(json.validation_messages.min)
    });
  });
}


$(document).ready(function() {

  $('#community_address').blur(function() {
     value = $('#community_address').val(); 
     city1 = /Ann Arbor/gi
     city2 = /Durham/gi
     cnt = 0;
     if(value.match(city1)) { cnt+1; }
     if(value.match(city2)) { cnt+1; }
    
    if (cnt == 0 && value != "" )
    { alert("RGF is now available only in Ann Arbor and Durham cities"); }
  });

  $("#status").live('change', function () {
    $(this).parents('form:first').submit();
  });

 
  $(".edit_comment_link").click(function () {
    var id = $(this).attr("id");
    var show_hide_edit_div = "edit_comment_" + id
    var show_hide_view_div = "view_comment_" + id
    if($("#" + show_hide_edit_div).css("display") === "none") {
      $("#" + show_hide_edit_div).show("slow");
      $("#" + show_hide_view_div).hide("slow");
      }
    else
      { $("#" + show_hide_edit_div).hide("slow");
        $("#" + show_hide_view_div).show("slow");
      }    
  });
  

});

