const apiResponse = {
    "pin_generic": [
        {
            "category": "ruby",
            "lat": -9.66583000,
            "long": -35.73528000,
            "total": 6,
            "id": 12939
        },
        {
            "category": "ruby",
            "lat": -9.66583000,
            "long": -35.73528000,
            "total": 6,
            "id": 12940
        },
        {
            "category": "ruby",
            "lat": -9.66583000,
            "long": -35.73528000,
            "total": 6,
            "id": 12940
        }
    ],
    "pin_costumer": [
        {
            "category": "ruby",
            "lat": -3.04361000,
            "long": -60.01282000,
            "id": 12939,
            "job": "3d620ad2-a16b-4812-95fb-33a06fe34f5f"
        }
    ]
};



async function parseValue(value) {
    const body = await value;
    return { body, status: 200 };
}

function fakeFetch(value) {
    return new Promise((resolve, reject) => {
        if (value == 1) {
            const body = parseValue(value);
            setTimeout(() => {
                resolve({ status: 200, body: apiResponse });
            }, 2000);
        } else {
            reject({ status: 503, body: { msg: 'Error no servidor. Tente Novamente' } });
        }
    });
}

function callToGeneric(lat, long, id) {
    console.log('Chamando as vagas desse pin: Passando, Lat, Long e Id');
    console.log({ lat, long, id });
}

function callToJob(job) {
    console.log('Chamando o job');
    console.log({ job });
}

function initMap() {
    var mapCanvas = document.getElementById("map");

    var mapOptions = {
        center: new google.maps.LatLng(-3.71722000, -38.54306000),
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
    var latLngCenter;
    map.addListener('idle', () => {
        const bounds = map.getBounds();
        const ne = bounds.getNorthEast();
        const sw = bounds.getSouthWest();
        latLngCenter = (new google.maps.LatLngBounds(sw, ne)).getCenter();
    });
    // PINS
    /* var markers = [
        genericos = [
            {
                category: "ruby",
                lat: -9.66583000,
                long: -35.73528000,
                total: 6,
                id: 12939
            },
            {
                category: "ruby",
                lat: -3.04361000,
                long: -60.01282000,
                total: 20,
                id: 12939
            },
        ],
        individual = [
            {
                category: "ruby",
                lat: -9.66583000,
                long: -35.73528000,
                id: 12939,
                job: "3d620ad2-a16b-4812-95fb-33a06fe34f5f"
            },
            {
                category: "ruby",
                lat: -3.04361000,
                long: -60.01282000,
                id: 12939,
                job: "3d620ad2-a16b-4812-95fb-33a06fe34f5f"
            },
        ],
    ]; */
    const existLatLngGeneric = [];
    const existLatLngCostumer = [];

    document.querySelectorAll('.filter-icon').forEach((filter) => {
        filter.addEventListener('click', (e) => {
            e.preventDefault();
            const center = `${latLngCenter}`;
            console.log(map.getZoom());
            console.log(center.split(','));
            console.log(`./URL_DUMMY/${filter.textContent.trim()}/${latLngCenter}/${map.getZoom()}`);
            fakeFetch(1).then((response) => {
                console.log(response);
                if (response.status == 200) {
                    response.body.pin_generic.forEach((value) => {
                        const { lat, long } = value;
                        const latLng = new google.maps.LatLng(lat, long);
                        if (!existLatLngGeneric.includes(`${lat}${long}`)) {
                            const { category, total: label, id } = value;
                            existLatLngGeneric.push(`${lat}${long}`);
                            const marker = new google.maps.Marker({
                                position: latLng,
                                icon: 'http://maps.google.com/mapfiles/ms/micons/green.png',
                                label: `${label}`,
                                map: map,
                            });
                            marker.addListener('click', callToGeneric.bind('click', lat, long, id));
                        } else {

                        }
                    });
                    response.body.pin_costumer.forEach((value) => {
                        const { lat, long } = value;
                        const latLng = new google.maps.LatLng(lat, long);
                        if (!existLatLngCostumer.includes(`${lat}${long}`)) {
                            const { category, lat, long, job, id } = value;
                            existLatLngCostumer.push(`${lat}${long}`);
                            const marker = new google.maps.Marker({
                                position: latLng,
                                icon: 'http://maps.google.com/mapfiles/ms/micons/green.png',
                                map: map,
                            });
                            marker.addListener('click', callToJob.bind('click', job));
                        }
                    })
                }
            }).then((res) => console.log({ existLatLngGeneric, existLatLngCostumer })).catch((err) => {
                alert(err);
            });
            /* fetch(`./URL_DUMMY/${filter.textContent.trim()}/`) */
        })
    });

    /*  markers_genericos.loop {
         var marker = new google.maps.Marker({
             position: [Maceio]],
             icon: icon: 'ICONE_PIN_GENERICO.png',
             label: "6",
             map: map
         });
     }
 
     // PIN INDIVIDUAL
     var markers_customers = [];
     markers_customers.loop {
         var marker = new google.maps.Marker({
             position: [ENDERECO DO CLIENTE]],
             icon: 'ICONE_PIN_INDIVIDUAL.png',
             map: map
         });
     }
  */

    // var marker = new google.maps.Marker({
    //     position: new google.maps.LatLng(-3.71722000,-38.54306000)
    // });
    // marker.setMap(map);

    // var markers = [];    
    // // make random red, yellow, blue markers
    // for (var i = 0; i < 800; i++) {
    //     var latLng = new google.maps.LatLng(-3.71 - Math.random(), -38.54 - Math.random());
    //     var marker = new google.maps.Marker({
    //         position: latLng,
    //         icon: 'http://maps.google.com/mapfiles/ms/micons/green.png',
    //         label: "" + i,
    //         map: map
    //     });
    //     markers.push(marker);
    // }

    // // define cluster icons
    // var mcOptions = {
    //     gridSize: 50,
    //     maxZoom: 15,
    //     styles: [{
    //         height: 50,
    //         url: "https://raw.githubusercontent.com/googlearchive/js-marker-clusterer/gh-pages/images/m1.png",
    //         width: 50
    //     },
    //     {
    //         height: 50,
    //         url: "https://raw.githubusercontent.com/googlearchive/js-marker-clusterer/gh-pages/images/m2.png",
    //         width: 50
    //     },
    //     {
    //         height: 50,
    //         url: "https://raw.githubusercontent.com/googlearchive/js-marker-clusterer/gh-pages/images/m3.png",
    //         width: 50
    //     }
    //     ]
    // };
    // var markerCluster = new MarkerClusterer(map, markers, mcOptions);


};
