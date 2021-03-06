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
            print(data["businesses"].count)
        }
        
        print(api.latitude)
        
        
        location.getCurrentLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 6.0)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera);
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    
}
