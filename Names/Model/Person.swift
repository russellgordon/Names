//
//  Person.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import Foundation
import SwiftUI

struct Person: Identifiable, Comparable, Codable {
    
    enum CodingKeys: CodingKey {
        case id, name, latitude, longitude, dateMet
    }

    let id: UUID
    let name: String
    let image: UIImage
    let latitude: Double
    let longitude: Double
    let dateMet: String
    
    init(id: UUID, name: String, image: UIImage, latitude: Double, longitude: Double, dateMet: String) {
        self.id = id
        self.name = name
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
        self.dateMet = dateMet
    }
    
    // Create an instance of this type by decoding from JSON
    init(from decoder: Decoder) throws {
        
        // Use the enumeration defined at top of structure to identify properties that will be decoded
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode each property
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        dateMet = try container.decode(String.self, forKey: .dateMet)

        // Get a URL that points to the saved image file for this person
        let filename = getDocumentsDirectory().appendingPathComponent(id.uuidString)
        
        // Attempt to load the image
        do {
            
            // Load the raw data
            let data = try Data(contentsOf: filename)
            
            #if DEBUG
            print("Got image data from file:")
            print(filename)
            #endif
            
            // Create a UIImage
            if let loadedImage = UIImage(data: data) {
                image = loadedImage
            } else {
                #if DEBUG
                print("Could not create UIImage for \(name) with id \(id.uuidString), setting placeholder image instead.")
                #endif
                image = UIImage(systemName: "person.fill.questionmark")!
            }
        } catch {
            
            #if DEBUG
            print(error.localizedDescription)
            print("Could not load raw image data for \(name) with id \(id.uuidString), setting placeholder image instead.")
            #endif
            
            image = UIImage(systemName: "questionmark.square.dashed")!
            
        }
        
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    // Encode an instance of this type to JSON and save binary image data to disk
    func encode(to encoder: Encoder) throws {
        
        // Use the enumeration defined at top of structure to identify values to be encoded
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode the first two properties and then save the image data separately in another file
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(dateMet, forKey: .dateMet)

        // Save the image data in a separate file in the Documents directory
        if let data = image.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent(id.uuidString)
            try? data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        }
    }
}

let testPerson = Person(id: UUID(),
                        name: "Rosario Nguyen",
                        image: UIImage(systemName: "person.fill.questionmark")!,
                        latitude: 37.334900,
                        longitude: -122.009020,
                        dateMet: "Sunday, July 21, 2019 9:41 AM")
 
