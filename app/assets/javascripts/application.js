// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require_tree .

$(function(){
  $('#shop_search').
    on('ajax:success', function(event, data, status, xhr) {
      $('#shops_list').html(data.shops_list);
    }).
    on('ajax:error', function(xhr, status, error) {
       console.log('error! : ', error);
    });

  $('#q_name_cont').on('keyup', function(){
    $('#shop_search').submit();
  });

  $('#facilities input').on('click', function(){
    $('#shop_search').submit();
  });

  var menuToggle = $('#js-mobile-menu').unbind();
  $('#js-navigation-menu').removeClass("show");

  menuToggle.on('click', function(e) {
    e.preventDefault();
    $('#js-navigation-menu').slideToggle(function(){
      if($('#js-navigation-menu').is(':hidden')) {
        $('#js-navigation-menu').removeAttr('style');
      }
    });
  });

  
});