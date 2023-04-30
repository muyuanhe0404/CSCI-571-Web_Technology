//
//  APIHandler.swift
//  mobile_search
//
//  Created by HMY on 4/14/23.
//

import Foundation
import Alamofire
class APIHandler{
    static let sharedInstance = APIHandler()
    let apiKey = "fCNma7FdtKa4QowUHCLWABSDGhxVQO7R"
    let host = "https://backend-dot-single-tide-380023.uc.r.appspot.com"
    let googleKey = "AIzaSyAF6ko5HSQ3milsvb2D1RnU_L-GDmsRhU0"
    func eventSearch(keyword:String, address:String, category:String, distance:Int, isAuto:Bool, handler: @escaping (SearchResposne?)->Void){
        let url = self.host + "/api/ticketmaster"
        let headers: HTTPHeaders = [:]
        let route: URL = URL(string: "url")!

        var originalRequest = try! URLRequest(url: url, method: .get, headers: headers)
        originalRequest.cachePolicy = .reloadIgnoringCacheData
        
        if (isAuto) {
            getIp { lat, lot in
                let dLat = Double(lat ?? "0")
                let dLot = Double(lot ?? "0")
                let encodedURLRequest = try! URLEncoding.default.encode(originalRequest, with: ["keyword": keyword, "location": address, "lat": dLat ?? 0, "lng": dLot ?? 0, "catagory": category, "distance": distance])
                AF.request(encodedURLRequest).response{responce in
                    switch responce.result{
                    case .success(let data):
                        do{
                            let jsondata = try JSONDecoder().decode(SearchResposne.self, from: data!)
                            handler(jsondata)
                        }catch{
                            handler(nil)
                        }
                    case .failure(let error):
                        handler(nil)
                    }
                }
            }
        } else {
            // https://backend-bpedzgmjba-uc.a.run.app/api/ticketmaster?keyword=Concert&catagory=KZFzniwnSyZfZ7v7nJ&distance=10&location=Newyork&lat=40.7127753&lng=-74.0059728
            getGeo(address: address) { resp in
                let lat = resp?.results?.first?.geometry?.location?.lat ?? 0
                let lot = resp?.results?.first?.geometry?.location?.lng ?? 0
                let encodedURLRequest = try! URLEncoding.default.encode(originalRequest, with: ["keyword": keyword, "location": address, "lat": lat ?? 0, "lng": lot ?? 0, "catagory": category, "distance": distance])
                AF.request(encodedURLRequest).response{responce in
                    switch responce.result{
                    case .success(let data):
                        do{
                            let jsondata = try JSONDecoder().decode(SearchResposne.self, from: data!)
                            handler(jsondata)
                        }catch{
                            handler(nil)
                        }
                    case .failure(let error):
                        handler(nil)
                    }
                }
            }
        }
    }
    
    func getSuggest(keywrod: String, handler: @escaping (SearchResposne?)->Void) {
        let url = "\(host)/api/suggestion"
        AF.request(url,method: .get,parameters: ["keyword": keywrod],encoding: URLEncoding.default, headers: nil,interceptor: nil).response{responce in
            switch responce.result{
            case .success(let data):
                do{
                    let jsondata = try JSONDecoder().decode(SearchResposne.self, from: data!)
                    handler(jsondata)
                }catch{
                    handler(nil)
                }
            case .failure(let error):
                handler(nil)
            }
        }
    }
    
    func getDetail(id: String, handler: @escaping (Event?)->Void) {
        let url = "\(host)/api/detail"
        AF.request(url,method: .get,parameters: ["id": id],encoding: URLEncoding.default, headers: nil,interceptor: nil).response{responce in
            switch responce.result{
            case .success(let data):
                do{
                    let jsondata = try JSONDecoder().decode(Event.self, from: data!)
                    handler(jsondata)
                }catch{
                    handler(nil)
                }
            case .failure(let error):
                handler(nil)
            }
        }
    }
    
    func searchArtist(artist: String, handler: @escaping (SearchArtistResp?)->Void) {
        let url = host + "/api/artist"
        AF.request(url,method: .get,parameters: ["artist":artist],encoding: URLEncoding.default, headers: nil,interceptor: nil).response{responce in
            switch responce.result{
            case .success(let data):
                do{
                    let jsondata = try JSONDecoder().decode(SearchArtistResp.self, from: data!)
                    handler(jsondata)
                }catch{
                    handler(nil)
                }
            case .failure(let error):
                handler(nil)
            }
        }
    }
    
    func getVenue(venue: String, handler: @escaping (SearchArtistResp?)->Void) {
        let url = host + "/api/venue"
        AF.request(url,method: .get,parameters: ["venue":venue],encoding: URLEncoding.default, headers: nil,interceptor: nil).response{responce in
            switch responce.result{
            case .success(let data):
                do{
                    let jsondata = try JSONDecoder().decode(SearchArtistResp.self, from: data!)
                    handler(jsondata)
                }catch{
                    handler(nil)
                }
            case .failure(let error):
                handler(nil)
            }
        }
    }
    
    func getGeo(address:String, handler: @escaping (GetGeoResp?)->Void) {
        let url = "https://maps.googleapis.com/maps/api/geocode/json"
        AF.request(url,method: .get,parameters: ["address":address, "key": googleKey],encoding: URLEncoding.default, headers: nil,interceptor: nil).response{responce in
            switch responce.result{
            case .success(let data):
                do{
                    let jsondata = try JSONDecoder().decode(GetGeoResp.self, from: data!)
                    handler(jsondata)
                }catch{
                    handler(nil)
                }
            case .failure(let error):
                handler(nil)
            }
        }
    }
    
    func getAlbum(id: String, handler: @escaping (SearchTrackResp?)->Void) {
        let url = "\(host)/api/album"
        let headers: HTTPHeaders = [:]
        let route: URL = URL(string: "url")!

        var originalRequest = try! URLRequest(url: url, method: .get, headers: headers)
        originalRequest.cachePolicy = .reloadIgnoringCacheData
        
        let encodedURLRequest = try! URLEncoding.default.encode(originalRequest, with: ["artid":id])
        AF.request(encodedURLRequest).response{responce in
            switch responce.result{
            case .success(let data):
                do{
                    let jsondata = try JSONDecoder().decode(SearchTrackResp.self, from: data!)
                    handler(jsondata)
                }catch{
                    handler(nil)
                }
            case .failure(let error):
                handler(nil)
            }
        }
    }
    
    func getIp(handler: @escaping (String?,String?)->Void) {
        let url = "https://ipinfo.io/?token=c25957d696b6c9"
        AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default, headers: nil,interceptor: nil).response{responce in
            switch responce.result{
            case .success(let data):
                do{
                    let jsondata = try JSONDecoder().decode(IPInfo.self, from: data!).loc ?? ""
                    let splitStr = jsondata.split(separator: ",")
                    if (splitStr.count > 1) {
                        handler(String(splitStr[0]),String(splitStr[1]))
                    } else {
                        handler(nil,nil)
                    }
                }catch{
                    handler(nil,nil)
                }
            case .failure(let error):
                handler(nil,nil)
            }
        }
    }
}
