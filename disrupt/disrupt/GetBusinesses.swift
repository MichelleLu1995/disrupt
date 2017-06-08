//
//  GetBusinesses.swift
//  disrupt
//
//  Created by Annette Chen on 6/7/17.
//  Copyright © 2017 Annette Chen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetBusinesses {
    
    var term = "food" //String()
    var latitude = Double()
    var longitude = Double()
    var radius = Int()
    var storeDeals: JSON = ""
    
    func getInfoFromAPI(completion: @escaping ((_ storeList: [Store]) -> Void)){
        var location = Location()
        location.getCurrentLocation()
        latitude = location.latitude
        longitude = location.longitude
        print("inside function")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer ArO4UNaUSgWgGhEcGycrp8csx77-t5IMl44vPf8woziVa2izC54kVPDtKKnQBwYevSOblu1B0lIk37a8cLqA6kPsi7Rb__ocKbXiAOSiQGk3Bs6dSGebso048304WXYx"
        ]
        
        var jsonResult:JSON = ""
        let search = term + "&latitude=\(latitude)&longitude=\(longitude)"//&radius=\(radius)"
        let url = "https://api.yelp.com/v3/businesses/search?term=" + search + "&sort_by=distance&limit=50&open_now=true"
        print(url)
        
        let request1 = Alamofire.request(url, headers: headers)
        request1.responseJSON {response in
            print("in alamo")
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)
            if let json = response.result.value {
                print("json response")
                jsonResult = JSON(json)
                print(jsonResult)
            }
            completion(jsonResult)
            
            let stores = self.createStoreList(json: jsonResult)
            let storesJSON = self.createJSONforServer(storeList: stores)
            
            let request2 = Alamofire.request("http://127.0.0.1:8080/getrewards", method: .post, parameters: storesJSON)
            request2.responseJSON { response2 in
                print("request:")
                print(response2.request)  // original URL request
                print("response:")
                print(response2.response) // HTTP URL response
                print("data:")
                print(response2.data)     // server data
                print("result:")
                print(response2.result)
                print("result value")
                print(response2.result.value)
                
                let json2 = response.result.value
                let jsonResult2 = JSON(json2)
                completion(jsonResult2)
            }
        }
        
        
    }
    
    func createJSONforServer(storeList: [Store]) -> [String]{
        var names = [String]()
        for store in storeList {
            names.append(store.name)
        }
//        var json:[String: Any] = ["userid": 4, "places": names]
        //        print(json)
    
//        return json
        return names
    }
    
    func getStoreDeals(storeList: [Store], completion: @escaping ((_ json: JSON) -> Void)) -> JSON{
        var jsonResult:JSON = ""
        var jsonInput = createJSONforServer(storeList: storeList)
        //        var url = "localhost:8080/getrewards"
        
        
        var j = ["userid" : 4, "places" : jsonInput] as [String : Any];
        
        let headers: HTTPHeaders = ["Content-Type":"application/json"]
//        let params: [String: Any] = jsonInput
        let params = j
        Alamofire.request("localhost:8080/getrewards", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("this is the request")

            print(response.request!)  // original URL request
            print(response.response) // HTTP URL response
            //            print(response.data)     // server data
            //            print(response.result)
            if let json = response.result.value {
                jsonResult = JSON(json)
                //                print(jsonResult)
                
            }
            completion(jsonResult)
        }
        return jsonResult
    }
    
    func createStoreList(json: JSON) -> [Store]{
        var storeList = [Store]()
        for index in (0...json["businesses"].count) {
            let data = json["businesses"][index]
            let location = Location()
            location.longitude = data["coordinates"]["longitude"].double == nil ? 0.00 : data["coordinates"]["longitude"].double!
            location.latitude = data["coordinates"]["latitude"].double == nil ? 0.00 : data["coordinates"]["longitude"].double!
            let store = Store()
            store.name = data["name"].string == nil ? "" : data["name"].string!
            store.distance = data["distance"].double == nil ? 0.00 : data["distance"].double!
            store.location = location
            store.street = data["address1"].string == nil ? "" : data["address1"].string!
            store.city = data["city"].string == nil ? "" : data["city"].string!
            store.state = data["state"].string == nil ? "" : data["state"].string!
            store.zipcode = data["zip_code"].string == nil ? "" : data["zip_code"].string!
            
            storeList.append(store)
            getStoreDeals(storeList: storeList) { [unowned self] data in
                print(data)
    
            }
            
        }
        return storeList
        
    }

   
    func createJSONforServer(storeList: [Store]) -> Parameters {
        var names = [String]()
        for store in storeList {
            names.append(store.name)
        }
        var json: Parameters = ["userid": 1, "places": names]
    	print(json)
    	return json
    } 
}

