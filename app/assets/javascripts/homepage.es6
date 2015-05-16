toastr.options = {
  "closeButton": false,
  "debug": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-bottom-center",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "2000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
};

jQuery(document).ready( () => {
  var el = $('.js-map');
  if (el.length === 0) {
    return;
  }
  window.map = new Map($('.js-map')[0]);
  var Router = Backbone.Router.extend({
    routes: {
      "map/:lat/:lng": "onMap"
    },
    onMap: function(lat,lng){
      map.setPosition(lat,lng);
    }
  });
  map.onMove(function(ev) {
    var [lat,lng] = this.getPosition();
    App.navigate(`map/${lat}/${lng}`);
  });
  window.App = new Router();

  Backbone.history.start() ;

  var pos = LS.get('position');
  if (pos) {
    App.navigate(`map/${pos[0]}/${pos[1]}`);
  } else {
    App.navigate("map/52.5170365/13.3888599");
    getGeoPos();
  }
});


$.fn.modal.defaults.spinner = $.fn.modalmanager.defaults.spinner =
  '<div class="loading-spinner" style="width: 200px; margin-left: -100px;">' +
  '<div class="progress progress-striped active">' +
  '<div class="progress-bar" style="width: 100%;"></div>' +
  '</div>' +
  '</div>';
