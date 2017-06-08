//
//  MapViewController.swift
//  disrupt
//
//  Created by Annette Chen on 6/7/17.
//  Copyright © 2017 Annette Chen. All rights reserved.
//


import UIKit
import MapKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class MapViewController: UIViewController {
    
    var api = GetBusinesses()
    
    var location = Location()
    
//    func callAPI(_ sender: Any) {
//        api.getInfoFromAPI { [unowned self] data in
//            print("here is the data >>>>>>>>>>>>>>>>>")
//            print(data["businesses"].count)
//        }
//    }
    
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the current location
        
        api.getInfoFromAPI { [unowned self] data in
            print("here is the data >>>>>>>>>>>>>>>>>")
            print(self.api.jsonResult2)
        }
        
        print(api.latitude)
        
        
        location.getCurrentLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 6.0)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera);
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.map = mapView
        
        func createMarker( marker : GMSMarker, mapView : GMSMapView, lat : Double, lon: Double, name : String, rewards: String ) {
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            marker.title = name
            marker.snippet =
                "Rewards: " + rewards
            
            
            marker.map = mapView
        }
        
        let currMarker = GMSMarker()
        createMarker(marker: currMarker, mapView: mapView, lat: location.latitude, lon: location.longitude, name: "Current Location", rewards: "none")
        
        var nearbyMarkers = [GMSMarker]()
        
        var lats = [40.711003, 40.711200, 40.711193 ]
        var lons = [-74.01, -74.01007, -74.01103 ]
        var rewards = ["15% of a purchase of $50 or more", "1 free drink with a party over 4 people", "one free cookie for kids under 6"]
        
        
        var names = ["Nish Nush", "Dark Horse", "Black Fox Coffee"]
        
        
        for index in 0...2 {
            let marker = GMSMarker()
            nearbyMarkers.append(marker)
            createMarker(marker: marker, mapView: mapView, lat: lats[index], lon: lons[index], name: names[index], rewards: rewards[index])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    
}
