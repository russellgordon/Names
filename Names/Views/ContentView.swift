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
    
    // Whether to show the add person dialog
    @State private var showingAddPerson = false
    
    var body: some View {
        
        // Show our list of users
        List(store.people.sorted()) { person in
            NavigationLink(destination: PersonDetailView(person: person)) {
                ListItemView(person: person)
            }
        }
        .animation(.default)
        .navigationTitle("Names")
        .sheet(isPresented: $showingAddPerson) {
            AddPersonView()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                
                Button("Add") {
                    showingAddPerson = true
                }
                
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button("Reset") {
                    store.people.removeAll()
                    store.saveData()
                }
                
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
