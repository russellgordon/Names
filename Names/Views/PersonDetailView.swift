//
//  PersonDetailView.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    
    var person: Person
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                
                VStack(alignment: .leading) {

                    Image(uiImage: person.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.9)
                    
                    Text("Met at:")
                        .font(.title3)
                        .bold()
                    
                    MapView(region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude,
                                                                                      longitude: person.longitude),
                                                       span: MKCoordinateSpan(latitudeDelta: 0.15,
                                                                              longitudeDelta: 0.15)),
                            annotations: [person])
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25)
                    
                }
                .padding()
            }
        }
        .navigationTitle(person.name)
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: testPerson)
    }
}
