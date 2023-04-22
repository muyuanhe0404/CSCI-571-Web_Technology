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
    let host = "https://app.ticketmaster.com/"
    func eventSearch(keyword:String, handler: @escaping (SearchResposne?)->Void){
        let url = host + "discovery/v2/events"
        AF.request(url,method: .get,parameters: ["keyword": keyword, "apikey": apiKey, "size": 1],encoding: URLEncoding.default, headers: nil,interceptor: nil).response{responce in
            switch responce.result{
            case .success(let data):
                do{
                    let jsondata = try JSONDecoder().decode(SearchResposne.self, from: data!)
                    handler(jsondata)
                }catch{
                    print("error")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getSuggest() {
        let url = "https://backend-bpedzgmjba-uc.a.run.app/api/check"
        AF.request(url,method: .get,parameters: nil,encoding: URLEncoding.default, headers: nil,interceptor: nil).response{responce in
            switch responce.result{
            case .success(let data):
                do{
                    let jsondata = try JSONDecoder().decode([SearchResposne].self, from: data!)
                    print(jsondata)
                }catch{
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
