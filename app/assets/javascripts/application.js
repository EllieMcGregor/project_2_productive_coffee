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
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function(){
  $('#shop_search').
    on('ajax:success', function(event, data, status, xhr) {
      $('#shops_list').html(data);
    }).
    on('ajax:error', function(xhr, status, error) {
       console.log('error! : ', error);
    });

    $('#q_name_cont').on('keyup', function(){
      $('#shop_search').submit();
    })
});

var myMap = myMap || {};

myMap.initialize = function(){
  var markerBounds = new google.maps.LatLngBounds();

  myMap.map = new google.maps.Map(myMap.mapElement);

  var shop_markers = gon.shop_markers_new;
  shop_markers.forEach(function(element, index, array){
    var shop_marker = element.position;
    point = new google.maps.LatLng(shop_marker.lat, shop_marker.lng);

    markerBounds.extend(point);
    var marker = new google.maps.Marker(element);
    marker.setMap(myMap.map);
  });

  myMap.locatorElement.on("click", function(){
    myMap.getPosition();
  });
 
  google.maps.event.addListener(myMap.map, 'zoom_changed', function() {
    zoomChangeBoundsListener = 
      google.maps.event.addListener(myMap.map, 'bounds_changed', function(event) {
        if (this.getZoom() > 15 && this.initialZoom == true) {
          this.setZoom(15);
          this.initialZoom = false;
        }
      google.maps.event.removeListener(zoomChangeBoundsListener);
    });
  });

  myMap.map.initialZoom = true;

  myMap.map.fitBounds(markerBounds);
}

$(function(){
  myMap.mapElement = $("#map-canvas")[0];
  myMap.locatorElement = $("#locator");
  myMap.initialize();
});

