//
//  MapViewController.swift
//  disrupt
//
//  Created by Annette Chen on 6/7/17.
//  Copyright © 2017 Annette Chen. All rights reserved.
//


import UIKit
import MapKit


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var location = Location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.getCurrentLocation()
        let userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        centerMapOnLocation(location: userLocation)
        
        // place a pin
        dropPin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let regionRadius: CLLocationDistance = 4000
    
    func centerMapOnLocation(location: CLLocation) {
        print(location.coordinate);
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func dropPin() {
        let droppedPin = MKPointAnnotation()
        droppedPin.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        droppedPin.title = "You are here"
        mapView.addAnnotation(droppedPin)
        print("dropped pin")
    }
    
}
