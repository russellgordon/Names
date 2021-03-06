//
//  PersonStore.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import Foundation

class PersonStore: ObservableObject {
            
    @Published var people: [Person] = []

    init() {
        
        // Get a URL that points to the saved JSON data containing our list of people
        let filename = getDocumentsDirectory().appendingPathComponent(fileLabel)
        
        // Attempt to load from the JSON in the stored file
        do {
            
            // Load the raw data
            let data = try Data(contentsOf: filename)
            
            #if DEBUG
            print("Got data from file, contents are:")
            print(String(data: data, encoding: .utf8)!)
            #endif
            
            // Decode the data into Swift native data structures
            self.people = try JSONDecoder().decode([Person].self, from: data)
            
        } catch {
            
            #if DEBUG
            print(error.localizedDescription)
            print("Could not load data from file, initializing with empty list.")
            #endif
            
            self.people = []
        }
        
    }
    
    // Save the list of people and their photograph names
    func saveData() {

        // Get a URL that points to the saved JSON data containing our list of people
        let filename = getDocumentsDirectory().appendingPathComponent(fileLabel)
        
        do {
            
            // Create an encoder
            let encoder = JSONEncoder()
            #if DEBUG
            encoder.outputFormatting = .prettyPrinted
            #endif
            
            // Encode the list of people we've tracked
            let data = try encoder.encode(self.people)
            
            // Actually write the JSON file to the documents directory
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            #if DEBUG
            print("Saved data to documents directory successfully.")
            #endif
            
        } catch {
            
            #if DEBUG
            print(error.localizedDescription)
            print("Unable to write list of people to documents directory.")
            #endif
        }
        
    }
    
}
