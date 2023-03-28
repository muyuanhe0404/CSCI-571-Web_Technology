
const express = require("express");
const bodyParser = require('body-parser')
const URL = 'https://app.ticketmaster.com/discovery/v2/events.json?&apikey=fCNma7FdtKa4QowUHCLWABSDGhxVQO7R';
const Detail = 'https://app.ticketmaster.com/discovery/v2/events/'
const Venue = 'https://app.ticketmaster.com/discovery/v2/venues.json?keyword='
const app = express();
const cliID = 'bb4f6b414a894874b364ff8f4b4307b4'
const clisecret = 'a6ff3a3c85d144fb8d30f5a181415943'
const ipbase ='https://ipinfo.io?token='
const iptoken ='c25957d696b6c9'
app.use(bodyParser.json())

var geohash = require('ngeohash');
var credentials = {
    clientId: 'bb4f6b414a894874b364ff8f4b4307b4',
    clientSecret: 'a6ff3a3c85d144fb8d30f5a181415943',
};
var SpotifyWebApi = require('spotify-web-api-node');
var spotifyApi = new SpotifyWebApi(credentials)
const ipinfo = require('ipinfo-express')
app.use(ipinfo({
    token: iptoken,
    cache: null,
    timeout: 5000,
    ipSelector: null
}))

spotifyApi.clientCredentialsGrant().then(
    function (data) {
        console.log("right now call",data.body)
        console.log('The access token expires in ' + data.body['expires_in']);
        console.log('The access token is ' + data.body['access_token']);

        // Save the access token so that it's used in future calls
        spotifyApi.setAccessToken(data.body['access_token']);
        //token = data.body['access_token']
        //console.log('token is ' + token);
        console.log('The access token is ' + spotifyApi.getAccessToken());
        app.get('/api/artist', async (req, res) => {
            console.log('a name', req.query.artist);
            spotifyApi.searchArtists(req.query.artist)
                .then(function (data) {
                    console.log('Search artists by bili', data.body);
                    res.json(data)
                }, function (err) {
                    console.log('The real access token is ' + spotifyApi.getAccessToken());
                    console.error(err);
                    spotifyApi.clientCredentialsGrant().then(
                        function (data) {
                            console.log("right now call",data.body)
                            console.log('The access token expires in ' + data.body['expires_in']);
                            console.log('The access token is ' + data.body['access_token']);
                    
                            // Save the access token so that it's used in future calls
                            spotifyApi.setAccessToken(data.body['access_token']);
                            //token = data.body['access_token']
                            //console.log('token is ' + token);
                            console.log('The access token is ' + spotifyApi.getAccessToken());
                            app.get('/api/artist', async (req, res) => {
                                console.log('a name', req.query.artist);
                                spotifyApi.searchArtists(req.query.artist)
                                    .then(function (data) {
                                        console.log("who",req.query.artist)
                                        console.log('Search artists by bili', data.body);
                                        res.json(data)
                                    }, function (err) {
                                        console.log('The real access token is ' + spotifyApi.getAccessToken());
                                        console.error(err);
                                    });
                                // res.status(200).json(data)
                            })
                            app.get('/api/album', async (req, res) => {
                                console.log('artid', req.query.artid);
                                spotifyApi.getArtistAlbums(req.query.artid, { limit: 3})
                                    .then(function (data) {
                                        console.log(data.body);
                                        res.json(data.body)
                                    }, function (err) {
                                        console.log('Something went wrong!', err);
                                    });
                                // res.status(200).json(data)
                            })
                        },
                        function (err) {
                            console.log('Something went wrong when retrieving an access token', err);
                        }
                        //console.log("ff",spotifyApi)
                    );
                });
            // res.status(200).json(data)
        })
        app.get('/api/album', async (req, res) => {
            console.log('artid', req.query.artid);
            spotifyApi.getArtistAlbums(req.query.artid, { limit: 3})
                .then(function (data) {
                    console.log(data.body);
                    res.json(data.body)
                }, function (err) {
                    console.log('Something went wrong!', err);
                });
            // res.status(200).json(data)
        })
    },
    function (err) {
        console.log('Something went wrong when retrieving an access token', err);
    }
    //console.log("ff",spotifyApi)
);
// console.log('The real access token is ' + spotifyApi.getAccessToken());
// spotifyApi.setAccessToken(token)
// spotifyApi.searchArtists('Love')
//   .then(function(data) {
//     console.log('Search artists by "Love"', data.body);
//   }, function(err) {
//     console.log('The real access token is ' + spotifyApi.getAccessToken());
//     console.error(err);
//   });

app.get('/', (req, res) => {
    res.json({ "message": "hello" })
})

app.get('/api/ticketmaster', async (req, res) => {
    console.log('req query', parseInt(req.query.distance));
    const geo = geohash.encode(Number(req.query.lat), Number(req.query.lng))
    console.log('geolat', Number(req.query.lat));
    console.log('geolng', Number(req.query.lng));
    console.log('geo', geo);
    const data = await fetch(`${URL}&keyword=${req.query.keyword}&segmentId=${req.query.catagory}&radius=${parseInt(req.query.distance)}&geoPoint=${geo}`).then(data => data.json());
    res.status(200).json(data)
})

app.get('/api/detail', async (req, res) => {
    console.log('id', req.query.id);
    const data = await fetch(`${Detail}${req.query.id}.json?apikey=fCNma7FdtKa4QowUHCLWABSDGhxVQO7R`).then(data => data.json());
    res.status(200).json(data)
})
app.get('/api/venue', async (req, res) => {
    console.log('venue name', req.query.venue);
    const data = await fetch(`${Venue}${req.query.venue}&apikey=fCNma7FdtKa4QowUHCLWABSDGhxVQO7R`).then(data => data.json());
    res.status(200).json(data)
})
app.get('/api/ip', async (req, res)=> {
    const data = await fetch(`${ipbase}${iptoken}`).then(data => data.json());
    res.status(200).json(data.loc)
})
// app.get('/api/artist', async (req, res) => {
//     console.log('a name', req.query.venue);
//     const data = await fetch(`${Venue}${req.query.venue}&apikey=fCNma7FdtKa4QowUHCLWABSDGhxVQO7R`).then(data => data.json());
//     res.status(200).json(data)
// })
app.get('/api/check', async (req, res) => {
    const geo = geohash.encode(34.0522, -118.3277)
    console.log('geolat', 34.0522);
    console.log('geolng', -118.3277);
    console.log('geo', geo);
    const data = await fetch(`${URL}&keyword=P!NK&segmentId=KZFzniwnSyZfZ7v7nJ&radius=10&geoPoint=${geo}`).then(data => data.json());
    res.status(200).json(data)
})


app.listen(process.env.PORT || 8080, (req, res) => {
    console.log("success");
})