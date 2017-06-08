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
    
    var term = "" //String()
    var latitude = Double()
    var longitude = Double()
    var radius = Int()
    
    func getInfoFromAPI(completion: @escaping ((_ json: JSON) -> Void)){
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
        let url = "https://api.yelp.com/v3/businesses/search?" + search + "&sort_by=distance&limit=10&open_now=true"
        print(url)
        Alamofire.request(url, headers: headers).responseJSON {response in
            print("in alamo")
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)
            if let json = response.result.value {
                print("json response")
                jsonResult = JSON(json)
                
                print(jsonResult)
                self.createStoreList(json: jsonResult)
            }
            completion(jsonResult)
        }
        
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
        }
        return storeList
        
    }
    
}

