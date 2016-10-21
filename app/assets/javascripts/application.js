// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-sprockets
//= require ckeditor/init
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  setTimeout(function() {
    $('.alert').fadeOut('normal');
  }, 8000);

  $('.sort-link-active').addClass('page-load-active');
  $('.sort-link').click(function () {
    $(this).siblings().removeClass('page-load-active');
    $(this).addClass('page-load-active');
  });

  $('.page>a,.first>a,.last>a,.next>a,.prev>a').click(function () {
    $('html, body').animate({
      scrollTop: $(".scrolltop-anchor").offset().top - 110
    }, 300);
  });
});

$(document).on('turbolinks:load', function() {
  $('textarea.ckeditor').each(function() {
    if($(this).css('visibility') != 'hidden')
      CKEDITOR.replace(this);
  });
  if(Turbolinks)
    Turbolinks.clearCache();
});

$(window).on("scroll", function() {
  var scrollPos = $(window).scrollTop();
  if (scrollPos <= 0) {
      $(".go-top").fadeOut();
  } else {
      $(".go-top").fadeIn();
  }
});

$(document).on('turbolinks:load', function() {
  $('#sidebar').affix({
    offset: {
      top: function () {
        return (this.top = $('.carousel').outerHeight(true))
      },
      bottom: function () {
        return (this.bottom = $('footer').outerHeight(true))
      }
    }
  });
});
