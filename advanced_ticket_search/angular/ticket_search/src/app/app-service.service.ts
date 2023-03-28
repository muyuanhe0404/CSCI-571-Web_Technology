import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
@Injectable({
  providedIn: 'root'
})
export class AppServiceService {

  constructor(private http : HttpClient ) { }

  baseUrl = 'http://localhost:3080'
  geoUrl = 'https://maps.googleapis.com/maps/api/geocode/json?'
  getData (params: any) {
    return this.http.get(`${this.baseUrl}/api/ticketmaster?${params}`)
  }
  getLoc (add: any,key:any) {
    return this.http.get(`${this.geoUrl}address=${add}&key=${key}`)
  }
  getDetail (id: any) {
    return this.http.get(`${this.baseUrl}/api/detail?${id}`)
  }
  getVenue (venue: any) {
    return this.http.get(`${this.baseUrl}/api/venue?${venue}`)
  }
  getArtist (artist: any) {
    return this.http.get(`${this.baseUrl}/api/artist?${artist}`)
  }
  getAlbum (artid: any) {
    return this.http.get(`${this.baseUrl}/api/album?${artid}`)
  }
  getIp () {
    return this.http.get(`${this.baseUrl}/api/ip?ip`)
  }
}
