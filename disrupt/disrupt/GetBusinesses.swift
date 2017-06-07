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
    var latitude = Int()
    var longitude = Int()
    
    func getInfoFromAPI(completion: @escaping (() -> Void)){
        var location = Location()
        location.getCurrentLocation()
        latitude = location.latitude
        longitude = location.longitude
        print("inside function")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer ArO4UNaUSgWgGhEcGycrp8csx77-t5IMl44vPf8woziVa2izC54kVPDtKKnQBwYevSOblu1B0lIk37a8cLqA6kPsi7Rb__ocKbXiAOSiQGk3Bs6dSGebso048304WXYx"
        ]
        
        var jsonResult:JSON = ""
        let search = term + "&latitude=\(latitude)&longitude=\(longitude)"
        let url = "https://api.yelp.com/v3/businesses/search?" + search
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
            }
            completion()
        }
    }
    
}
