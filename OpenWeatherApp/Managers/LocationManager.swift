//
//  LocationManager.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 17.01.2024.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate{
    
    // Variables
    lazy var manager = CLLocationManager()
    static let shared = LocationManager()
    private var locationFetchCompletion: ((CLLocation) -> Void)?
    weak var location: CLLocation? {
        didSet {
            guard let location = location else { return }
            locationFetchCompletion?(location)
        }
    }
    
    // Override Init
    private override init() {
        super.init()
    }
    
    // Get Current Location
    public func getCurrentLocation(completion: @escaping (CLLocation) -> Void) {
        locationFetchCompletion = completion
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        } else {
            print("ERROR FETCH USER LOCATION")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
        manager.stopUpdatingLocation()
    }
}

