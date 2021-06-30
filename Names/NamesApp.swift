//
//  NamesApp.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import SwiftUI

@main
struct NamesApp: App {
    
    // App icon by:
    // Charles Etoroma on Unsplash
    // https://unsplash.com/@charlesetoroma
    
    // Initialize our data store
    @StateObject var store = PersonStore()
    
    // Create an object to use for location services within the app
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView {
                ContentView()
                    // Make the data store available to other views
                    .environmentObject(store)
                    // Make location manager available to other views through the environment
                    .environmentObject(locationManager)
            }
            
        }
    }
}
