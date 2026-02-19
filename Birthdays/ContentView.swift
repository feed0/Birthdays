//
//  ContentView.swift
//  Birthdays
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 16/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - Properties
    
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    @State private var newName = ""
    @State private var newDate = Date.now
    @State private var newNotes = ""
    @State private var selectedFriend: Friend?
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List(friends) { friend in
                HStack {
                    if friend.isBirthdayToday {
                        birthdayCakeIcon
                    }
                    friendNameText(for: friend)
                    Spacer()
                    friendBirthdayDateText(for: friend)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFriend = friend
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                    newBirthdayHeaderText
                    datePicker
                    saveNewFriendButton
                }
                .padding()
                .background(.bar)
            }
            .sheet(item: $selectedFriend) { friend in
                FriendNotesEditor(friend: friend)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var birthdayCakeIcon: some View {
        Image(systemName: "birthday.cake")
    }
    
    private func friendNameText(for friend: Friend) -> some View {
        Text(friend.name)
            .bold(friend.isBirthdayToday)
    }
    
    private func friendBirthdayDateText(for friend: Friend) -> some View {
        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
    }
    
    // MARK: Add new friend
    
    private var newBirthdayHeaderText: some View {
        Text("New Birthday")
            .font(.headline)
    }
    
    private var datePicker: some View {
        DatePicker(selection: $newDate,
                   in: Date.distantPast...Date.now,
                   displayedComponents: .date) {
            TextField("Name", text: $newName)
                .textFieldStyle(.roundedBorder)
            TextField("Notes (optional)", text: $newNotes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(3, reservesSpace: true)
        }
    }
    
    private var saveNewFriendButton: some View {
        Button("Save") {
            insertNewFriend()
            resetNewFriendFields()
        }
        .bold()
    }
    
    // MARK: - Private funcs
    
    private func insertNewFriend() {
        let newFriend = Friend(
            name: newName,
            birthday: newDate,
            notes: newNotes,
        )
        
        context.insert(newFriend)
    }
    
    private func resetNewFriendFields() {
        newName = ""
        newDate = .now
        newNotes = ""
    }
}

// MARK: - Preview

#Preview {
    ContentView()
        .modelContainer(
            for: Friend.self,
            inMemory: true)
}
