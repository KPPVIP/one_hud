$(function () {
  function display(bool) {
      if (bool) {
          $(".hud-settings").fadeIn();
          $(".fade").fadeIn();
      } else {
          $(".hud-settings").fadeOut();
          $(".fade").fadeOut();
      }
  }

  display(false)

  window.addEventListener('message', function(event) {
      var item = event.data;
      
      if(item.action == "hudsettings") {
          if (item.status == true) {
              display(true)
          } else {
              display(false)
          }
      }
  })
});

$(function(){
	window.addEventListener('message', function(event) {
		if (event.data.action == "setValue") {
			setValue(event.data.key, event.data.value)
		}
	});

});

function setValue(key, value){
	$('#' +key+ ' span').html(value)
}

function closehudsettings() {
    $(".hud-settings").fadeOut();
    $(".fade").fadeOut();
    $.post("https://one_hud/hudsettings-close", JSON.stringify({}))
}

$(document).keyup(function(event) {
  if (event.which === 27) {
      closehudsettings()
  }
});