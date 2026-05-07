//
//  GiftRow.swift
//  Birthdays
//
//  Created by feed0 on 07/05/26.
//

import SwiftUI

struct GiftRow: View {
    
    // MARK: - Init
    
    init(
        gift: Gift,
        friend: Friend,
    ) {
        self.gift = gift
        self.friend = friend
    }
    
    // MARK: - Properties
    
    private let gift: Gift
    private let friend: Friend
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            priceText
            dotSeparator
            NavigationLink(gift.title) {
                giftDetail
            }
        }
    }
    
    // MARK: - Subviews
    
    private var priceText: some View {
        Text(gift.priceString)
    }
    
    private var dotSeparator: some View {
        Text(".")
    }
    
    private var titleText: some View {
        Text(gift.title)
    }
    
    private var giftDetail: some View {
        GiftDetail(
            gift: gift,
            friend: friend,
        )
    }
    
    // MARK: - Private Methods
    
}

// MARK: - Previews

#Preview("Component") {
    GiftRow(
        gift: Gift.sampleData[0],
        friend: Friend.sampleData[0],
    )
}

#Preview("In a NavigationStack") {
    NavigationStack {
        List {
            GiftRow(
                gift: Gift.sampleData[0],
                friend: Friend.sampleData[0],
            )
        }
    }
}
