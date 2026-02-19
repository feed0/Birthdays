//
//  FriendNotesEditor.swift
//  Birthdays
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 19/02/26.
//

import SwiftUI

struct FriendNotesEditor: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var friend: Friend
    @State private var draftNotes: String
    
    // MARK: - Init
    
    init(friend: Friend) {
        self.friend = friend
        _draftNotes = State(initialValue: friend.notes)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                friendNameText
                friendBirthdayText
                friendNotesLabelText
                notesTextEditor
                
                Spacer()
            }
            .padding()
            .navigationTitle("Edit Notes")
            .toolbar {
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
    
    private var friendNameText: some View {
        Text(friend.name)
            .font(.headline)
    }

    private var friendBirthdayText: some View {
        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }

    private var friendNotesLabelText: some View {
        Text("Notes")
            .font(.caption)
            .foregroundStyle(.secondary)
    }

    private var notesTextEditor: some View {
        TextEditor(text: $draftNotes)
            .frame(minHeight: 160)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.quaternary, lineWidth: 1)
            )
            .padding(.top, 4)
    }
    
    // MARK: - Private funcs
    
    private var cancelButton: some View {
        Button("Cancel") {
            dismiss()
        }
    }
    
    private var saveButton: some View {
        Button("Save") {
            friend.notes = draftNotes
            dismiss()
        }
        .bold()
    }
}

// MARK: - Preview

#Preview {
    let friend = Friend(
        name: "Oliver J. Smith",
        birthday: Date(),
        notes: "Buy him a new Helicopter for his brand new yatch that his nephew gave him."
    )
    
    FriendNotesEditor(friend: friend)
}
