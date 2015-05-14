var LS = {
  get: function(key) {
    var value = localStorage[key];
    if(value !== undefined) {
      return JSON.parse(value);
    }
  },
  set: function(key,val) {
    localStorage[key] = JSON.stringify(val);
  }
};
