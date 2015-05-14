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
    this.drinks = this.data.drink_ids.map( (drink_id) => {
      return Drinks[drink_id];
    });
    if(this.drinks === undefined) {
      this.drinks = [];
    }
    this.marker = L.marker([hash.lat, hash.lon]).
      addTo(map.map).
      bindPopup(this.popup());
  }
  popup() {
    var d = this.drinks.map( (drink) => {
      return `<span class='label label-default'>${drink.name}</span>`;
    });
    return `
      <strong>${this.data.name}</strong>
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

