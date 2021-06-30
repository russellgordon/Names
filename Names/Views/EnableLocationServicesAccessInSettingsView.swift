//
//  EnableLocationServicesAccessInSettingsView.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-30.
//

import SwiftUI

struct EnableLocationServicesAccessInSettingsView: View {
        
    var body: some View {
        ScrollView {

            VStack {
                
                VStack (alignment: .leading) {
                                        
                    HStack {
                        Spacer()
                        Image("location_services_enable")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 225, height: 225)
                            .padding(.bottom)
                        Spacer()
                    }
                    
                    // Show context for why
                    Text("""
                        Your location is used only by this app to record where you were when you added the name of a person you wish to remember.
                        
                        Your location information is saved securely on your device and never transmitted elsewhere.
                        """)
                        .font(.title2)
                        .padding(.bottom)
                        .minimumScaleFactor(0.75)
                    
                    Text("Please open Settings to grant location services access.")
                        .font(.title2)
                        .padding(.bottom)
                        .minimumScaleFactor(0.75)
                    
                    HStack {
                        
                        Spacer()
                        
                        Button("Open Settings") {
                            
                            // Open Settings to the entry for this app
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                            
                        }
                        .padding(.bottom)

                        Spacer()
                    }
                    
                    Text("If necessary, navigate to:")
                        .font(.title2)
                        .padding(.bottom)
                        .minimumScaleFactor(0.75)
                    
                    Text("Privacy > Location Services > Names")
                        .bold()
                        .font(.title2)
                        .padding(.bottom)
                        .minimumScaleFactor(0.75)
                    
                    Text("Then select:")
                        .font(.title2)
                        .padding(.bottom)
                        .minimumScaleFactor(0.75)
                    
                    Text("While Using the App")
                        .bold()
                        .font(.title2)
                        .padding(.bottom)
                        .minimumScaleFactor(0.75)
                    
                }

            }
            .padding()           
            
        }
    }
}

struct EnableLocationServicesAccessInSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        EnableLocationServicesAccessInSettingsView()
    }
}
