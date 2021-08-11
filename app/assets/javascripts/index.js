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
            setTimeout(() => {
                reject({ status: 503, body: { msg: 'Error no servidor. Tente Novamente' } });

            }, 2000);
        }
    });
}

function generateLoader() {
    return `
    <div class="loader-wrapper">
        <span class="loader">
            <span class="loader-inner"></span>
        </span>
    </div>
    `;
}

function handleLoadingHtmlChange() {
    document.querySelector('.scroll-wrapper').classList.remove('invisible');
    const wrapperResults = document.querySelector('#ts-results');
    wrapperResults.innerHTML = generateLoader() + wrapperResults.innerHTML;
}

function handleCleanLoading() {
    const wrapperResults = document.querySelector('#ts-results');
    const loader = wrapperResults.querySelector('.loader-wrapper')
    if (!!loader) {
        wrapperResults.removeChild(loader);
    }
}

function appendToTsResults(tsResultsWrapper) {
    const wrapperResults = document.querySelector('#ts-results');
    wrapperResults.appendChild(tsResultsWrapper);
}

function handleErrorHtmlChange(tsResultsWrapper, lat, long, id) {
    handleCleanLoading();
    console.log(tsResultsWrapper);
    tsResultsWrapper.innerHTML = `
        <div class="loader-wrapper">
            <div class="error-inner">
                <span class="error-text">Parece que houve um erro ao carregar, clique no botão para carregar novamente</span>
                <button button-retry class="btn btn-primary">Carregar Novamente</button>
            </div>
        </div>
    `;
    appendToTsResults(tsResultsWrapper);
    document.querySelector("[button-retry]").addEventListener('click', (e) => {
        e.preventDefault();
        callToGeneric(lat, long, id);
    });
}

function cleanErrorHtml(tsResultsWrapper) {
    tsResultsWrapper.innerHTML = '';
}

var previousGeneric = false;
let tsResultsWrapper = document.querySelector('.ts-results-wrapper');
function callToGeneric(lat, long, id) {
    console.log('Chamando as vagas desse pin: Passando, Lat, Long e Id');
    console.log({ lat, long, id });
    if (!tsResultsWrapper) {
        tsResultsWrapper = document.createElement('div');
        tsResultsWrapper.classList.add('ts-results-wrapper');
    } else {
        cleanErrorHtml(tsResultsWrapper);
    }
    previousGeneric = true;
    handleLoadingHtmlChange();
    fakeFetch(0).then((response) => {
        return response;
    }).then(({ body }) => {
        body.pin_generic.forEach((pin) => {
            tsResultsWrapper.innerHTML = tsResultsWrapper.innerHTML + `<div class="ts-result-link" data-ts-id="16" data-ts-ln="15">
            <span class="ts-center-marker">
              <img src="assets/img/result-center.svg">
            </span>
            <a href="detail-01.html" class="card ts-item ts-card ts-result">
              <div class="ts-ribbon"><i class="fa fa-thumbs-up"></i></div>
              <div href="detail-01.html" class="card-img ts-item__image"
                style="background-image: url(assets/img/img-item-thumb-16.jpg)"></div>
              <div class="card-body">
                <div class="ts-item__info-badge">$185,900</div>
                <figure class="ts-item__info">
                  <h4>Residental House on Quite Place</h4>
                  <aside><i class="fa fa-map-marker mr-2"></i>605 Dennett Place, Tooleville</aside>
                </figure>
                <div class="ts-description-lists">
                  <dl>
                    <dt>Area</dt>
                    <dd>356m<sup>2</sup></dd>
                  </dl>
                  <dl>
                    <dt>Bedrooms</dt>
                    <dd>2</dd>
                  </dl>
                  <dl>
                    <dt>Bathrooms</dt>
                    <dd>1</dd>
                  </dl>
                  <dl>
                    <dt>Rooms</dt>
                    <dd>1</dd>
                  </dl>
                </div>
              </div>
              <div class="card-footer">
                <span class="ts-btn-arrow">Detail</span>
              </div>
            </a>
          </div>`
        });
    }).then(() => {
        appendToTsResults(tsResultsWrapper);
    }).catch((err) => {
        console.log(err);
        handleErrorHtmlChange(tsResultsWrapper, lat, long, id);
        return err;
    }).finally(() => {
        return;
    });
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
    map.addListener('click', () => {
        document.querySelector('.scroll-wrapper').classList.add('invisible');
        document.querySelector('#ts-results').innerHTML = '';
    })
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

    let markers = [];
    var mcOptions = {
        gridSize: 50,
        maxZoom: 15,
        styles: [{
            height: 50,
            url: "https://raw.githubusercontent.com/googlearchive/js-marker-clusterer/pages/images/m1.png",
            width: 50
        },
        {
            height: 50,
            url: "https://raw.githubusercontent.com/googlearchive/js-marker-clusterer/pages/images/m2.png",
            width: 50
        },
        {
            height: 50,
            url: "https://raw.githubusercontent.com/googlearchive/js-marker-clusterer/pages/images/m3.png",
            width: 50
        }
        ]
    };

    var markerCluster = {};

    let previousLayer = '';
    document.querySelectorAll('.filter-icon').forEach((filter) => {
        filter.addEventListener('click', (e) => {
            e.preventDefault();
            if (previousGeneric) {
                document.querySelector('.scroll-wrapper').classList.add('invisible');
                document.querySelector('#ts-results').innerHTML = '';
            }
            const center = `${latLngCenter}`;
            console.log(map.getZoom());
            console.log(center.split(','));
            console.log(`./URL_DUMMY/${filter.textContent.trim()}/${latLngCenter}/${map.getZoom()}`);
            fakeFetch(1).then((response) => {
                if (previousLayer) {
                    markerCluster[previousLayer].clearMarkers();
                }
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
                            });
                            marker.addListener('click', callToGeneric.bind('click', lat, long, id));
                            markers.push(marker);
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
                            });
                            marker.addListener('click', callToJob.bind('click', job));
                            markers.push(marker);
                        }
                    })
                    previousLayer = filter.textContent.trim();
                    markerCluster[previousLayer] = new MarkerClusterer(map, markers, mcOptions);
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
    // var markerCluster = new MarkerClusterer(map, markers, mcOptions);


};
