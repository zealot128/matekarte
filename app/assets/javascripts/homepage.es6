
jQuery(document).ready( () => {
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
