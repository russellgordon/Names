//
//  Person.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import Foundation

struct Person: Identifiable, Comparable, Codable {

    enum CodingKeys: CodingKey {
        case name, photo
    }

    let id = UUID()
    let name: String
    let photo: UUID
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
