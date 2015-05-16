var GeoPosition = {
  getGeoPosition:  () => {
    toastr.info('Position wird ermittelt...');
    navigator.geolocation.getCurrentPosition(
      (position) => {
        toastr.clear();

        var c = [position.coords.latitude, position.coords.longitude];
        LS.set('position', c);
        toastr.success('Position ermittelt.');
        App.navigate(`map/${c[0]}/${c[1]}`, { trigger: true });
      },
      (error) => {
        toastr.clear();
        toastr.error('Fehler bei Positionsermittlung.');
      }
    );
  }
};

$(document).on('click', '.js-get-geopos', (ev) => {
  ev.preventDefault();
  GeoPosition.getGeoPosition();
});
