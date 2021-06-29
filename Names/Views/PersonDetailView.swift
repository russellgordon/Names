//
//  PersonDetailView.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import SwiftUI

struct PersonDetailView: View {
    
    var person: Person
    
    var body: some View {
        VStack {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        .navigationTitle(person.name)
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: testPerson)
    }
}
