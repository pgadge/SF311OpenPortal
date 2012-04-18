/* Constructor for an extended Marker class */
function LabeledMarker(latlng, options){
    this.latlng = latlng;
    this.labelText = options.labelText || "";
    this.labelClass = options.labelClass || "markerLabel";
    this.labelOffset = options.labelOffset || new GSize(0, 0);
    GMarker.apply(this, arguments);
}


/* It's a limitation of JavaScript inheritance that we can't conveniently
   extend GMarker without having to run its constructor. In order for the
   constructor to run, it requires some dummy GLatLng. */
LabeledMarker.prototype = new GMarker(new GLatLng(0, 0));


// Creates the text div that goes over the marker.
LabeledMarker.prototype.initialize = function(map) {
        // Do the GMarker constructor first.
        GMarker.prototype.initialize.call(this, map);

        var div = document.createElement("div");
        div.className = this.labelClass;
        div.innerHTML = this.labelText;
        div.style.position = "absolute";
        map.getPane(G_MAP_MARKER_PANE).appendChild(div);
        
        this.map = map;
        this.div = div;
}

// Redraw the rectangle based on the current projection and zoom level
LabeledMarker.prototype.redraw = function(force) {
        GMarker.prototype.redraw.call(this, map);
        
        // We only need to do anything if the coordinate system has changed
        if (!force) return;
        
        // Calculate the DIV coordinates of two opposite corners of our bounds to
        // get the size and position of our rectangle
        var p = this.map.fromLatLngToDivPixel(this.latlng);
        var z = GOverlay.getZIndex(this.latlng.lat());
        
        // Now position our DIV based on the DIV coordinates of our bounds
        this.div.style.left = (p.x + this.labelOffset.width) + "px";
        this.div.style.top = (p.y + this.labelOffset.height) + "px";
        this.div.style.zIndex = z + 1; // in front of the marker
}

// Remove the main DIV from the map pane
LabeledMarker.prototype.remove = function() {
  this.div.parentNode.removeChild(this.div);
  this.div = null;
  GMarker.prototype.remove.call(this);
}