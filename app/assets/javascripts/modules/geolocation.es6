var GeoPosition = {
  getGeoPosition:  () => {
    navigator.geolocation.getCurrentPosition(function(position) {
      var c = [position.coords.latitude, position.coords.longitude];
      LS.set('position', c);
      App.navigate(`map/${c[0]}/${c[1]}`, { trigger: true });
    });
  }
};

$(document).on('click', '.js-get-geopos', (ev) => {
  ev.preventDefault();
  GeoPosition.getGeoPosition();
});
