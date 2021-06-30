//
//  ListItemView.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import SwiftUI

struct ListItemView: View {
    
    var person: Person
    
    var body: some View {
        HStack {
            
            Image(uiImage: person.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44)
            
            VStack(alignment: .leading) {
                
                Text("\(person.name)")
            }
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(person: testPerson)
    }
}
