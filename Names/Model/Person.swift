//
//  Person.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import Foundation

struct Person: Identifiable, Comparable, Codable {

    enum CodingKeys: CodingKey {
        case id, name
    }

    let id: UUID
    let name: String
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
