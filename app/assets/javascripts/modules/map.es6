L.Icon.Default.imagePath = '/assets/leaflet';
window.Dealers = {};
window.Drinks = {};
$.get('/drinks.json', (data) => {
  data.forEach( (el) => {
    window.Drinks[el.id] = el;
  });
});

class Dealer {
  constructor(map, hash) {
    this.data = hash;
    this.drinks = _.map(this.data.cached_drinks,  (status, drink_id) => {
      return [ Drinks[parseInt(drink_id)], status ];
    });
    if(this.drinks === undefined) {
      this.drinks = [];
    }

    this.marker = L.marker([hash.lat, hash.lon], { icon: this.icon() }).
      addTo(map.map).
      bindPopup(this.popup());
  }
  icon() {
    var marker;
    if (this.drinks.length === 0) {
      marker = L.AwesomeMarkers.icon({
        icon: 'shopping-cart',
        prefix: 'fa',
        markerColor: 'gray'
      });
    } else  {
      marker = L.AwesomeMarkers.icon({
        icon: 'shopping-cart',
        prefix: 'fa',
        markerColor: 'blue'
      });
    }
    return marker;
  }
  popup() {
    var d = this.drinks.map( (map) => {
      var [drink,status] = map;
      var cssClass;
      if (status === 1) {
        cssClass = 'success';
      } else if (status === 0) {
        cssClass = 'danger';
      } else {
        cssClass = 'warning';
      }
      return `<span class='label label-${cssClass}'>${drink.name}</span>`;
    });
    return `
      <strong><a href='/dealers/${this.data.id}' class='js-modal'>${this.data.name}</a></strong>
      <br/>${this.data.address}
      <br/> ${this.data.city}
      <p>${d.join(' ')}</p>
    `;
  }
}

class Map {
  constructor(element) {
    this.map = L.map(element);
    window.map = this.map;
    var url = "http://{s}.tile.osm.org/{z}/{x}/{y}.png";
    L.tileLayer(url, {
      attribution: `&copy;
      <a href="http://osm.org/copyright">OpenStreetMap</a> contributors /
      <a href="https://lyrk.de">Lyrk</a>`
    }).addTo(this.map);
  }
  updateInfo() {
    var {lat, lng} = this.map.getCenter();
    $.get("/dealers.json", { lat: lat, lon: lng }, (data) => {
      data.forEach( (shop_data) => {
        if(!Dealers[shop_data.id]) {
          Dealers[shop_data.id] = new Dealer(this, shop_data);
        }
      });
    });
  }
  setPosition(lat,lng,zoom=11) {
    this.map.setView([lat,lng], zoom);
    this.updateInfo();
  }
  getPosition() {
    var {lat, lng} = this.map.getCenter();
    return [lat, lng];
  }
  onMove(fn) {
    this.map.on('moveend', (ev) => {
      this.updateInfo();
      fn.bind(this)(ev);
    });
  }
}

