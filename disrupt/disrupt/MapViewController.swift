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
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        
        let currMarker = GMSMarker()
        createMarker(marker: currMarker, mapView: mapView, lat: location.latitude, lon: location.longitude)
        
        var nearbyMarkers = [GMSMarker]()
        
        //temp
        for index in 1...10 {
            let marker = GMSMarker()
            nearbyMarkers.append(marker)
            createMarker(marker: marker, mapView: mapView, lat: (location.latitude + Double(index)), lon: (location.longitude + Double(index)))
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createMarker( marker : GMSMarker, mapView : GMSMapView, lat : Double, lon: Double ) {
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.title = "Name"
        marker.snippet =
            "Cashback: " + String(lat) + "\n" +
            "Rewards" + String(lon)
        
        marker.map = mapView
    }
    
   
    
//    @IBOutlet weak var segmentedControl: UISegmentedControl!
//    
//    @IBOutlet weak var mapView: UIView!
//    @IBOutlet weak var listView: UIView!
//    
//    @IBAction func indexChanged(sender: UISegmentedControl) {
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//            mapView.isHidden = true
//            listView.isHidden = false
//        case 1:
//            mapView.isHidden = false
//            listView.isHidden = true
//        default:
//            break;
//        }
//    }
    
}
