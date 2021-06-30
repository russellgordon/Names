//
//  LocationHandler.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-06-30.
//

import CoreLocation
import Foundation
import SwiftUI

/*
 Placemark support adapted from these tutorials:
 
 https://dev.to/andrewlundydev/core-location-how-to-display-a-human-readable-address-using-clgeocoder-lng
 
 https://adrianhall.github.io/swift/2019/11/05/swiftui-location/
 
 */

enum LocationServicesStatus: String {
    case firstRun           // User has never run the app before, so show an explanation of why LocationServices is required
    case denied             // User refused permission for LocationServices, so explain that app requires it to be run, must change in Settings
    case granted            // User granted permission for LocationServices
}

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var locationServicesStatus: LocationServicesStatus = .firstRun
    
    // For use in getting a human-readable address
    private let geocoder = CLGeocoder()

    // A human-readable address tied to the last known location
    private var placemark: CLPlacemark?
    
    var placemarkDescription: String {
        
        let notFound = "Address could not be found."

        guard let placemark = placemark else { return notFound }

        guard let streetNumber = placemark.subThoroughfare else {
            #if DEBUG
            print("street number not found")
            #endif
            return notFound
        }
        guard let streetName = placemark.thoroughfare else {
            #if DEBUG
            print("street name not found")
            #endif
            return notFound
        }
        guard let city = placemark.locality else {
            #if DEBUG
            print("city not found")
            #endif
            return notFound
        }
        guard let administrativeArea = placemark.administrativeArea else {
            #if DEBUG
            print("administrative area not found")
            #endif
            return notFound
        }
        guard let postalCode = placemark.postalCode else {
            #if DEBUG
            print("postal code not found")
            #endif
            return notFound
        }
        guard let country = placemark.country else {
            #if DEBUG
            print("country not found")
            #endif
            return notFound
        }

        // Rationalize output when there is a significant placemark name "Apple Campus" vs. when there is not
        var name = placemark.name ?? ""
        if name == "\(streetNumber) \(streetName)" {
            name = ""
        } else {
            name += "\n"
        }
        
        return "\(name)\(streetNumber) \(streetName)\n\(city), \(administrativeArea)\n\(postalCode)\n\(country)"
        
    }
    
    
    // The human-readable address
    
    let manager = CLLocationManager()
    
    private var location: CLLocation?

    var lastKnownLocation: CLLocationCoordinate2D? {
        return location?.coordinate
    }
        
    override init() {
        super.init()
        manager.delegate = self
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Save last known location for use with geocoding
        location = locations.first
        
        // Get a human-readable address for this location
        reverseGeocode()
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
    
    // Get a human-readable address
    private func reverseGeocode() {
        
        // Ensure that we have a location to work with
        guard let location = location else { return }
        
        // This runs asynchronously
        geocoder.reverseGeocodeLocation(location) { (places, error) in
            
            // If a human-readable address was found, update the property
            if error == nil {
                self.placemark = places?.first
            } else {
                self.placemark = nil
            }
            
        }
        
    }
    
}
