//
//  FriendDetail.swift
//  Birthdays
//
//  Created by feed0 on 19/02/26.
//

import SwiftUI
import SwiftData

struct FriendDetail: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // MARK: Friend
    @Bindable var friend: Friend
    private let isNewFriend: Bool
    
    // MARK: Gift
    @State private var newGift: Gift?
    
    // MARK: Computed Properties
    
    private var navigationTitle: String {
        isNewFriend ? "Add friend" : "Edit friend"
    }
    
    // MARK: - Init
    
    init(
        friend: Friend,
        isNewFriend: Bool = false,
    ) {
        self.friend = friend
        self.isNewFriend = isNewFriend
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Form {
                friendNameTextField
                friendBirthdayDatePicker
                notesTextField
                
                if !isNewFriend {
                    Section("Gifts") {
                        if friend.gifts.isEmpty {
                            emptyGiftListContentUnavailableView
                        } else {
                            List {
                                ForEach(friend.gifts) { gift in
                                    giftRow(for: gift)
                                }
                                .onDelete(perform: handleDeleteFriendGiftRelationship(indexes:))
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNewFriend {
                ToolbarItem(placement: .cancellationAction) {
                    cancelAddFriendButton
                }
                ToolbarItem(placement: .confirmationAction) {
                    saveFriendButton
                }
            } else {
                ToolbarItem {
                    addGiftButton
                }
                ToolbarItem {
                    editListButton
                }
            }
        }
        .sheet(item: $newGift) { gift in
            NavigationStack {
                newGiftDetail(for: gift)
            }
            .interactiveDismissDisabled()
        }
    }
    
    // MARK: - Subviews
    
    // MARK: Friend info section
    
    private var friendNameTextField: some View {
        TextField(
            "Friend name",
            text: $friend.name,
        )
        .font(.headline)
    }
    
    private var friendBirthdayDatePicker: some View {
        DatePicker(
            "Birthday",
            selection: $friend.birthday,
            displayedComponents: .date,
        )
    }
    
    private var notesTextField: some View {
        TextField(
            "Notes",
            text: $friend.notes,
        )
    }
    
    // MARK: Gifts section
    
    private var emptyGiftListContentUnavailableView: some View {
        ContentUnavailableView(
            "Add gifts",
            systemImage: "gift",
        )
    }
    
    private func giftRow(for gift: Gift) -> some View {
        GiftRow(
            gift: gift,
            friend: friend,
        )
    }
    
    private func newGiftDetail(for gift: Gift) -> some View {
        GiftDetail(
            gift: gift,
            isNewGift: true,
            friend: friend,
        )
    }
    
    // MARK: Add friend toolbar buttons
    
    private var cancelAddFriendButton: some View {
        Button("Cancel") {
            handleCancelButton()
        }
    }
    
    private var saveFriendButton: some View {
        Button("Save") {
            handleSaveButton()
        }
        .bold()
    }
    
    // MARK: Gift toolbar buttons
    
    private var addGiftButton: some View {
        Button(
            "Add gift",
            systemImage: "gift.fill",
            action: handleAddGiftButton,
        )
    }
    
    private var editListButton: some View {
        EditButton()
    }
    
    // MARK: - Private funcs
    
    // MARK: Add friend toolbar actions
    
    private func handleCancelButton() {
        context.delete(friend)
        dismiss()
    }
    
    private func handleSaveButton() {
        dismiss()
    }
    
    // MARK: Gift actions
    
    private func handleAddGiftButton() {
        let newGift = Gift(
            title: "",
            price: 0,
        )
        
        context.insert(newGift)
        self.newGift = newGift
    }
    
    private func handleDeleteFriendGiftRelationship(indexes: IndexSet) {
        for index in indexes {
            let gift = friend.gifts[index]
            friend.gifts.remove(at: index)
            context.delete(gift)
        }
    }
}

// MARK: - Previews

// MARK: Edit friend

#Preview("Edit friend") {
    NavigationStack {
        FriendDetail(
            friend: Friend.sampleData[3],
        )
    }
}

// MARK: New friend

#Preview("New friend") {
    NavigationStack {
        FriendDetail(
            friend: Friend.sampleData[3],
            isNewFriend: true,
        )
    }
}

// MARK: Friend with gifts

#Preview("Friend with gifts") {
    NavigationStack {
        FriendDetail(
            friend: Friend.sampleData[0],
        )
    }
    .modelContext(SampleData.shared.context)
}

// MARK: Friend with NO gifts

#Preview("Friend with NO gifts") {
    NavigationStack {
        FriendDetail(
            friend: Friend.sampleData[3],
        )
    }
    .modelContext(SampleData.shared.context)
}
