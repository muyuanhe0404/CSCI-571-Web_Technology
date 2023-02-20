from flask import Flask, jsonify,abort
from flask import *
import requests
from geolib import geohash
GOOGLE_MAP_KEY = 'AIzaSyCOoPxTu5ATqZVs0Xocnlcz0vQHOCqV-Kw' 
ur = "https://app.ticketmaster.com/discovery/v2/events.json?size=1&apikey=fCNma7FdtKa4QowUHCLWABSDGhxVQO7R&radius=1000&geoPoint=dr5regw"

def find_geo(address):
    base = "https://maps.googleapis.com/maps/api/geocode/json?"
    key = GOOGLE_MAP_KEY 
    search_address = f"{base}address={address}&key={key}"
    r = requests.get(search_address)
    if r.status_code not in range(200, 299):
        return None, None
    try:
        results = r.json()['results'][0]
        lat = results['geometry']['location']['lat']
        lng = results['geometry']['location']['lng']
    except:
        return None,None
    return lat, lng

# def find_ticket():
#     apikey= YOUR_API_KEY
# &keyword=University+of+Southern+California&segmentId=KZFzniwnSyZfZ7v7nE
# &radius=10&unit=miles&geoPoint=9q5cs
#     base = "https://app.ticketmaster.com/discovery/v2/events.json?"
#     key = GOOGLE_MAP_KEY 
#     search_address = f"{base}address={address}&key={key}"
#     r = requests.get(search_address)
#     if r.status_code not in range(200, 299):
#         return None, None
#     try:
#         results = r.json()['results'][0]
#         lat = results['geometry']['location']['lat']
#         lng = results['geometry']['location']['lng']
#     except:
#         return None,None
#     return lat, lng

app = Flask(__name__, static_folder='static', static_url_path='')

@app.route("/")
def homepage():
    #return "hello"
    return app.send_static_file("events.html")

@app.route("/get_result",methods = ['POST'])
def result():
    #  response = requests.get("https://app.ticketmaster.com/discovery/v2/events.json?size=1&apikey=fCNma7FdtKa4QowUHCLWABSDGhxVQO7R&radius=1000&geoPoint=dr5regw")
    #  results = response.json()
    #  return results
     if request.method == "POST":
        check = request.form["check"]
        if check == "1":
            lat,lng = request.form["location"].split(",")
        else:    
            location = request.form["location"]
            lat,lng = (find_geo(location))
        #print(lat,lng)
        if lat == None:
            geoh = None
        else:
            geoh = geohash.encode(lat, lng, 7)
        #print(geoh)
        #https://app.ticketmaster.com/discovery/v2/events.json?size=1&apikey=fCNma7FdtKa4QowUHCLWABSDGhxVQO7R&radius=1000&geoPoint=dr5regw
        base = "https://app.ticketmaster.com/discovery/v2/events.json?"
        key =  "fCNma7FdtKa4QowUHCLWABSDGhxVQO7R",
        radius = request.form["distance"]
        segment = request.form["catagory"]
        keyword = request.form["keyword"]
        if segment == "":
            search_address = f"{base}&apikey=fCNma7FdtKa4QowUHCLWABSDGhxVQO7R&keyword{keyword}&radius={radius}&geoPoint={geoh}"
        else:
            search_address = f"{base}&apikey=fCNma7FdtKa4QowUHCLWABSDGhxVQO7R&keyword{keyword}&segmentId={segment}&radius={radius}&geoPoint={geoh}"
        response = requests.get(search_address)
         
        return response.json()


@app.route('/search', methods = ['POST','GET'])
def get_data():
    if request.method == "POST":
        location = request.form["location"]
        print(location)
        lat,lng = (find_geo(location))
        print(lat,lng)
        if lat == None:
            geoh = None
        else:
            geoh = geohash.encode(lat, lng, 7)
        print(geoh)
        return redirect(url_for("get_data"))
    else:
        return app.send_static_file("events.html")
        
if __name__ == "__main__":
    app.run()
