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
//= require bootstrap-datepicker
//= require chartkick
//= require detect_timezone
//= require jquery.detect_timezone
//= require bootstrap
//= require masonry/jquery.masonry
//= require masonry/jquery.imagesloaded.min
//= require mediaelement_rails
//= require bootstrap-modal
//= require turbolinks
//= require_tree .

jQuery(document).ready(function($) {
	$('#myModal').modal('show');
    $('#youtube1').mediaelementplayer({
    
    });

$(function(){
 $('body').on('click', '.addcals', function(event) {
$(this).empty();
$(this).html("Thank you!");
    event.preventDefault();
});    
});

$(document).ready(function(){
  $("[rel='tooltip']").tooltip();
    })

$(document).ready(function(){
    $('#timezone').set_timezone();
})

$(function(){

  var $container = $('#masonry-container');

  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector: '.box',
      animate: true,
      isFitWidth: true
    });
  }); 


  var $container2 = $('#masonry-container2');

  $container2.imagesLoaded(function(){
    $container2.masonry({
      itemSelector: '.box',
      animate: true,
      isFitWidth: true
    });
  }); 

var $container3 = $('#masonry-container3');

  $container3.imagesLoaded(function(){
    $container3.masonry({
      itemSelector: '.box',
      animate: true,
      isFitWidth: true
    });
  }); 
$('#filters').on('click', 'a', function() {
        var selector = $(this).data('filter');
        $container3.isotope({
            filter: selector
        });
    });

});


$( ".viral" ).click(function() {
 $('#myModal').modal('hide');
 $('#myModal2').modal('show');
 return false;
});

});