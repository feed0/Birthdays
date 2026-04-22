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
    
    @Bindable var friend: Friend
    
    private let isNewFriend: Bool
    
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
        Form {
            friendNameTextField
            friendBirthdayDatePicker
            notesTextField
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNewFriend {
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
    
    // MARK: Notes section
    
    private var notesTextField: some View {
        TextField(
            "Notes",
            text: $friend.notes,
        )
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
        .bold()
    }
    
    // MARK: - Private funcs
    
    private func handleCancelButton() {
        context.delete(friend)
        dismiss()
    }
    
    private func handleSaveButton() {
        dismiss()
    }
}

// MARK: - Preview

// MARK: Edit friend

#Preview {
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
