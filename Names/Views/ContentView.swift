//
//  ContentView.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import SwiftUI

struct ContentView: View {

    // Access to location manager
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {

        VStack {
            
            switch locationManager.locationServicesStatus {
            case .firstRun:
                // Initial explanation of why location services is needed
                RequestLocationServicesAccessView()
            case .denied:
                // User chose to disable location services; explain why and how it's used in more detail
                EnableLocationServicesAccessInSettingsView()
            case .granted:
                // Show the app's list of names
                ListView()
            }
        }
        .navigationTitle("Names")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
