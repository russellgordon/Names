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
                Text("\(person.id)")
                    .font(.caption)
            }
        }
        .animation(.default)
        .navigationTitle("Names")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                
                Button("Add") {
                    addPerson()
                }
                
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button("Reset") {
                    store.people.removeAll()
                }
                
            }
        }
    }
    
    // Add a dummy entry for now
    func addPerson() {
        
        let placeholderNames = ["Bryan Osborn",
                                "Taylor Cooke",
                                "Edgar Washington",
                                "Williams Grant",
                                "Terrell Stein",
                                "Jamar Salinas",
                                "Katie Aguirre",
                                "Ava Mcdowell",
                                "Damian Glass",
                                "Drew Parker",
                                "Nadine Guerrero",
                                "Tyron Lloyd",
                                "Kurt Carpenter",
                                "Jarvis Hess",
                                "Willy Weaver",
                                "Seymour Esparza",
                                "Angelo Lambert",
                                "Millard Richards",
                                "Jesse Casey",
                                "Danielle Finley",
                                "Jamaal Carson",
                                "Lauren Rice",
                                "Irma Brandt",
                                "Carolyn Santana",
                                "Margret Barajas",
                                "Pearlie Pena",
                                "Shanna Mcfarland",
                                "Stanley Gates",
                                "Rashad Jones",
                                "Marcus Mills",
                                "Merle Keller",
                                "Anastasia Payne",
                                "Eli Morse",
                                "Clarence Brewer",
                                "Faustino Mann",
                                "Noel Fritz",
                                "Sydney Solomon",
                                "Stanford Burke",
                                "Ida Winters",
                                "Pamela Mcgrath",
                                "Rosario Nguyen",
                                "Chandra Copeland",
                                "Zelma Gillespie",
                                "Sherwood Ford",
                                "Arlene Beltran",
                                "Lynn Patrick",
                                "Carrie Horton",
                                "Minerva Rich",
                                "Porfirio Novak",
                                "Priscilla Day",]
        
        // Try to avoid same name
        var newName = ""
        var uniqueName = true
        repeat {
            
            // Get a new name
            newName = placeholderNames.randomElement()!
            
            // Assume new name is unique until shown otherwise
            uniqueName = true
            
            // Check to see if name already exists in list of people
            for person in store.people {
                if person.name == newName {
                    uniqueName = false
                    break
                }
            }
            
        } while uniqueName == false && store.people.count < 50
        
        // Add a person to the list
        store.people.append(Person(id: UUID(),
                                   name: newName))
        
        // Save that person to permanent storage
        store.saveData()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
