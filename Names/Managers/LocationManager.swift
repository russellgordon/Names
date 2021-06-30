//
//  LocationHandler.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-06-30.
//

import CoreLocation
import Foundation
import SwiftUI

enum LocationServicesStatus: String {
    case firstRun           // User has never run the app before, so show an explanation of why LocationServices is required
    case denied             // User refused permission for LocationServices, so explain that app requires it to be run, must change in Settings
    case granted            // User granted permission for LocationServices
}

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var locationServicesStatus: LocationServicesStatus = .firstRun

    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        
        // This request runs asynchronously...
        manager.requestWhenInUseAuthorization()
        
        // Start updating the location of the user...
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
    
    // "If you do not implement this method, Core Location throws an exception when attempting to use location services.
    // The location manager calls this method when it encounters an error trying to get the location or heading data."
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if let error = error as? CLError {
            switch error {
            case CLError.denied:
                #if DEBUG
                print("Location services permissions denied.")
                #else
                break
                #endif
            default:
                break
            }
        }
        
    }
    
    // This will be invoked after the user has decided how to respond to the request to track location
    //
    // "After the user makes a selection and determines the status, the location manager delivers the results to the delegate's locationManagerDidChangeAuthorization method..."
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Report on what option the user selected
        _ = validateLocationAuthorizationStatus()
        
    }
    
    // Reports on what the user selected
    func validateLocationAuthorizationStatus() -> CLAuthorizationStatus {
        switch manager.authorizationStatus {
        case .denied:
            
            #if DEBUG
            print("Location Services Was Denied")
            #endif
            
            // Set state
            locationServicesStatus = .denied

        case .restricted:
            #if DEBUG
            print("Location Services Status Is Restricted")
            #endif
        case .notDetermined:
            #if DEBUG
            print("Location Services Status Was Not Determined")
            #endif
        case .authorizedWhenInUse:
            #if DEBUG
            print("Location Services Authorized When App In Use")
            #endif
        
            // Set state
            locationServicesStatus = .granted
            
        case .authorizedAlways:
            #if DEBUG
            print("Location Services Always Authorized")
            #endif
        default:
            break
        }
        
        return manager.authorizationStatus
    }
    
}
