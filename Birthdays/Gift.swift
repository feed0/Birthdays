//
//  Gift.swift
//  Birthdays
//
//  Created by feed0 on 07/05/26.
//

import Foundation
import SwiftData

@Model
class Gift {
    
    // MARK: - Init
    
    init(
        title: String,
        price: Int,
    ) {
        self.title = title
        self.price = price
    }
    
    // MARK: - Properties
    
    var title: String
    var price: Int
    
    // MARK: Computed properties
    
    var priceString: String {
        "$\(price)"
    }
}

// MARK: - Mock data

extension Gift {
    static let sampleData: [Gift] = [
        .init(
            title: "Perfum",
            price: 100,
        ),
        .init(
            title: "Boat",
            price: 100_000,
        ),
        .init(
            title: "Helicopter",
            price: 1_000_000,
        ),
        .init(
            title: "Watch",
            price: 50_000,
        ),
    ]
}
