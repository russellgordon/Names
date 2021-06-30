//
//  MapView.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-30.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @State var region: MKCoordinateRegion
    
    @State var annotations: [Person]
    
    var body: some View {
        
        Map(coordinateRegion: $region, annotationItems: annotations) { location in
            
            MapPin(coordinate: CLLocationCoordinate2D(latitude: location.latitude,
                                                      longitude: location.longitude))
            
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: testPerson.latitude,
                                                                          longitude: testPerson.longitude),
                                           span: MKCoordinateSpan(latitudeDelta: 0.75,
                                                                  longitudeDelta: 0.75)),
                annotations: [testPerson])
    }
}
