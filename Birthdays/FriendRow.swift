//
//  FriendRow.swift
//  Birthdays
//
//  Created by feed0 on 22/04/26.
//

import SwiftUI

struct FriendRow: View {
    
    // MARK: - Properties
    
    private let friend: Friend
    
    // MARK: - Init
    
    init(friend: Friend) {
        self.friend = friend
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            
            if friend.isBirthdayToday {
                birthdayCakeIcon
            }
            
            friendBirthdayDateText(for: friend)
            
            dotSeparator
            
            NavigationLink(friend.name) {
                friendDetail(for: friend)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var birthdayCakeIcon: some View {
        Image(systemName: "birthday.cake")
    }
    
    private func friendBirthdayDateText(for friend: Friend) -> some View {
        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
    }
    
    private var dotSeparator: some View {
        Text(".")
    }
    
    private func friendDetail(for friend: Friend) -> some View {
        FriendDetail(friend: friend)
    }
}

// MARK: - Preview

#Preview("Component") {
    let mockFriend = Friend.sampleData.first!
    FriendRow(friend: mockFriend)
}

#Preview("In a List inside a NavigationSplitView") {
    let mockFriend = Friend.sampleData.first!
    
    NavigationSplitView {
        List {
            FriendRow(friend: mockFriend)
        }
    } detail: {
        Text("Select a friend") /// placeholder for the detail view
            .navigationTitle("Friend")
            .navigationBarTitleDisplayMode(.inline)
    }
}
