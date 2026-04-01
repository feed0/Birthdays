//
//  Friend.swift
//  Birthdays
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 16/02/26.
//

import Foundation
import SwiftData

@Model
class Friend {
    
    // MARK: - Properties
    
    var name: String
    var birthday: Date
    var notes: String = ""
    
    // MARK: - Init
    
    init(name: String,
         birthday: Date,
         notes: String = "",
    ) {
        self.name = name
        self.birthday = birthday
        self.notes = notes
    }
    
    // MARK: - Computed properties
    
    var isBirthdayToday: Bool {
        Calendar.current.isDateInToday(birthday)
    }
}

// MARK: - Mock data

extension Friend {
    static let sampleData: [Friend] = [
        .init(
            name: "Feed0", 
            birthday: Date(),
        ),
        .init(
            name: "Alice Wonder",
            birthday: Calendar.current.date(byAdding: .year, value: 10, to: Date()) ?? Date(),
        ),
        .init(
            name: "Jack Sparrow",
            birthday: Calendar.current.date(byAdding: .year, value: -1000, to: Date()) ?? Date(),
        ),
        .init(
            name: "Oliver J. Smith",
            birthday: Calendar.current.date(byAdding: .year, value: 10, to: Date()) ?? Date(),
            notes: "Buy him a new Helicopter for his brand new yatch that his nephew gave him.",
        )
    ]
}
