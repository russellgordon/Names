//
//  ContentView.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import SwiftUI

struct ContentView: View {
    
    // Access our data store
    @EnvironmentObject var store: PersonStore
    
    var body: some View {
        
        // Show our list of users
        List(store.people.sorted()) { person in
            VStack(alignment: .leading) {
                Text("\(person.name)")
                Text("\(person.photo)")
                    .font(.caption)
            }
        }
        .navigationTitle("Names")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                
                Button("Add") {
                    addPerson()
                }
                
            }
        }
    }
    
    // Add a dummy entry for now
    func addPerson() {
        
        let placeholderNames = ["Clare Mitchell",
                                "Florine Douglas",
                                "Filiberto Cameron",
                                "Alfreda Mcdonald",
                                "Elena Kemp",
                                "Kelvin Carr",
                                "Patrick Schroeder",
                                "Daphne Trujillo",
                                "Emile Huff",
                                "Leta Vance",
                                "Devin Rollins",
                                "Antony Leon",
                                "Latonya Fowler",
                                "Francis Perry",
                                "Janna Conley",
                                "Candy Gaines",
                                "Eula Todd",
                                "Merle Mclean",
                                "Debora King",
                                "Francesco Zuniga",
                                "Sung Boyer",
                                "Nora Boyle",
                                "Bart Guerrero",
                                "Lindsey Middleton",
                                "Jamal Ramirez",]
        
        // Add a person to the list
        store.people.append(Person(name: placeholderNames.randomElement() ?? "Jane Doe",
                                   photo: UUID()))
        
        // Save that person to permanent storage
        store.saveData()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
