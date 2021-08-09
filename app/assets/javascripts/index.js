function initMap() {
    var mapCanvas = document.getElementById("map");

    var mapOptions = {
        center: new google.maps.LatLng(-3.71722000,-38.54306000),
        zoom: 13,
        minZoom: 1,
        maxZoom: 15,
        panControl: false, 
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        overviewMapControl: false,
        rotateControl: false,
        zoomControl: false,
		zoomControlOptions: {
			style: google.maps.ZoomControlStyle.SMALL
		}
    };

    var map = new google.maps.Map(mapCanvas, mapOptions);

    // var marker = new google.maps.Marker({
    //     position: new google.maps.LatLng(-3.71722000,-38.54306000)
    // });
    // marker.setMap(map);

    var markers = [];    
    // make random red, yellow, blue markers
    for (var i = 0; i < 800; i++) {
        var latLng = new google.maps.LatLng(-3.71 - Math.random(), -38.54 - Math.random());
        var marker = new google.maps.Marker({
            position: latLng,
            icon: 'http://maps.google.com/mapfiles/ms/micons/green.png',
            label: "" + i,
            map: map
        });
        markers.push(marker);
    }

    // define cluster icons
    var mcOptions = {
        gridSize: 50,
        maxZoom: 15,
        styles: [{
            height: 50,
            url: "https://raw.githubusercontent.com/googlearchive/js-marker-clusterer/gh-pages/images/m1.png",
            width: 50
        },
        {
            height: 50,
            url: "https://raw.githubusercontent.com/googlearchive/js-marker-clusterer/gh-pages/images/m2.png",
            width: 50
        },
        {
            height: 50,
            url: "https://raw.githubusercontent.com/googlearchive/js-marker-clusterer/gh-pages/images/m3.png",
            width: 50
        }
        ]
    };
    var markerCluster = new MarkerClusterer(map, markers, mcOptions);
   

};
