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
    
    
    var location = Location()
    
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the current location
        
        location.getCurrentLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 3.0)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera);
        view = mapView
        
        // Creates a marker in the center of the map.
        
//        let currMarker = GMSMarker()
//        createMarker(marker: currMarker, mapView: mapView, lat: location.latitude, lon: location.longitude)
//        
//        var nearbyMarkers = [GMSMarker]()
//        
//        //temp
//        for index in 1...10 {
//            let marker = GMSMarker()
//            nearbyMarkers.append(marker)
//            createMarker(marker: marker, mapView: mapView, lat: (location.latitude + Double(index)), lon: (location.longitude + Double(index)))
//        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    
}
