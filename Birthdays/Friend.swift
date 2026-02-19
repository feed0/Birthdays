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
