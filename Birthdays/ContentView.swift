//
//  ContentView.swift
//  Birthdays
//
//  Created by feed0 on 16/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // MARK: - Properties
    
    @Query(sort: \Friend.birthday) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    @State private var newFriend: Friend?
    
    // MARK: - Body
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(friends) { friend in
                    friendRow(for: friend)
                }
                .onDelete(perform: handleDeleteFriends(indexes:))
            }
            .navigationTitle("Birthdays")
            .toolbar {
                ToolbarItem {
                    addFriendButton
                }
                ToolbarItem {
                    editListButton
                }
            }
            .sheet(item: $newFriend) { friend in
                NavigationStack {
                    newFriendDetail(for: friend)
                }
                .interactiveDismissDisabled()
            }
        } detail: {
            defaultDetailLink
        }
    }
    
    // MARK: - Subviews
        
    private func friendRow(for friend: Friend) -> some View {
        FriendRow(friend: friend)
    }
    
    private func newFriendDetail(for friend: Friend) -> some View {
        FriendDetail(
            friend: friend,
            isNewFriend: true
        )
    }
    
    // MARK: Atoms
    
    private var addFriendButton: some View {
        Button(
            "Add friend",
            systemImage: "plus",
            action: handleAddFriendButton
        )
    }
    
    private var editListButton: some View {
        EditButton()
    }
    
    private var defaultDetailLink: some View {
        Text("Select a friend")
            .navigationTitle("Friend")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Private funcs
    
    private func handleDeleteFriends(indexes: IndexSet) {
        for index in indexes {
            let friend = friends[index]
            context.delete(friend)
        }
    }
    
    private func handleAddFriendButton() {
        let newFriend = Friend(
            name: "",
            birthday: Date.now,
            notes: "",
        )
        
        context.insert(newFriend)
        self.newFriend = newFriend
    }
}

// MARK: - Preview

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
