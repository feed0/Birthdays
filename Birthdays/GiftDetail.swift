//
//  GiftDetail.swift
//  Birthdays
//
//  Created by feed0 on 07/05/26.
//

import SwiftUI
import SwiftData

struct GiftDetail: View {

    // MARK: - Init
    
    init(
        gift: Gift,
        isNewGift: Bool = false,
        friend: Friend,
    ) {
        self.gift = gift
        self.isNewGift = isNewGift
        self.friend = friend
    }
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Bindable var gift: Gift
    private let isNewGift: Bool
    @Bindable var friend: Friend
    
    // MARK: Computed properties
    
    private var navigationTitle: String {
        isNewGift ? "New gift" : "Edit gift"
    }
    
    // MARK: - Body
    
    var body: some View {
        Form {
            giftTitleTextField
            giftPriceTextField
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNewGift {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }
                ToolbarItem(placement: .confirmationAction) {
                    saveButton
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    private var giftTitleTextField: some View {
        TextField(
            "Gift name",
            text: $gift.title,
        )
        .font(.headline)
    }
    
    private var giftPriceTextField: some View {
        TextField(
            "Gift price",
            value: $gift.price,
            format: .number,
        )
        .keyboardType(.numberPad)
    }
    
    // MARK: Toolbar buttons
    
    private var cancelButton: some View {
        Button("Cancel") {
            handleCancelButton()
        }
    }
    
    private var saveButton: some View {
        Button("Save") {
            handleSaveButton()
        }
    }
    
    // MARK: - Private Methods
    
    private func handleCancelButton() {
        context.delete(gift)
        dismiss()
    }
    
    private func handleSaveButton() {
        friend.gifts.append(gift)
        dismiss()
    }
}

// MARK: - Previews

// MARK: Edit

#Preview("Edit gift") {
    NavigationStack {
        GiftDetail(
            gift: Gift.sampleData.first!,
            friend: Friend.sampleData[0],
        )
    }
}

// MARK: Add

#Preview("New gift") {
    NavigationStack {
        GiftDetail(
            gift: Gift.sampleData.first!,
            isNewGift: true,
            friend: Friend.sampleData[0],
        )
    }
}
