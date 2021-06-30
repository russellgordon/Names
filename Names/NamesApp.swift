//
//  NamesApp.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import SwiftUI

@main
struct NamesApp: App {
    
    // Initialize our data store
    @StateObject var store = PersonStore()
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView {
                ContentView()
                    // Make the data store available to other views
                    .environmentObject(store)
            }
            
        }
    }
}
