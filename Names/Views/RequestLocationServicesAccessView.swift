//
//  RequestLocationServicesAccessView.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-30.
//

import SwiftUI

struct RequestLocationServicesAccessView: View {
        
    // Access to location manager
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        
        ScrollView {
            
            VStack {
                
                VStack(alignment: .leading) {
                    
                    // Show user help
                    Text("To provide additional context and help you remember the names of people you've met, please enable location services.\n\nWhen you add a new name to this app, we will display a map showing where you were!")
                        .font(.title2)
                        .padding(.bottom)
                }
                
                Image("location_services_access")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding(.bottom)
                    .accessibility(hidden: true)
                
                // Button to check out user function defined below
                Button("Enable Location Services") {
                    // Get the user's location
                    locationManager.start()
                }
                
                Spacer()
                
            }
            .padding()

        }
    }
}

struct RequestLocationServicesAccessView_Previews: PreviewProvider {
    static var previews: some View {
        RequestLocationServicesAccessView()
    }
}
