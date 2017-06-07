//
//  Location.swift
//  disrupt
//
//  Created by Larry Heimann on 11/17/15.
//  Copyright (c) 2015 Larry Heimann. All rights reserved.


import Foundation
import CoreLocation

class Location: NSObject, NSCoding {
    
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var locationManager = CLLocationManager()
    
    override init() {
        self.latitude = 0.00
        self.longitude = 0.00
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.latitude = aDecoder.decodeDouble(forKey: "Latitude") as CLLocationDegrees
        self.longitude = aDecoder.decodeDouble(forKey: "Longitude") as CLLocationDegrees
        super.init()
        print("Recovered Lat: \(self.latitude)")
        print("Recovered Lon: \(self.longitude)")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.latitude, forKey: "Latitude")
        aCoder.encode(self.longitude, forKey: "Longitude")
        print("Saved Lat: \(self.latitude)")
        print("Saved Lon: \(self.longitude)")
    }
    
    func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        print("Manager: \(locationManager)")
        print("Location: \(locationManager.location)")
        
        if let currLocation = locationManager.location {
            self.latitude = currLocation.coordinate.latitude
            self.longitude = currLocation.coordinate.longitude
        }
        print("Calculated Lat: \(self.latitude)")
        print("Calculated Lon: \(self.longitude)")
    }
    
}
