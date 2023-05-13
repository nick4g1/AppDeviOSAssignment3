//
//  FriendScrollView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 13/5/2023.
//

import SwiftUI

struct FriendsScrollView: View {
    @Binding var amount: Double
    @Binding var selectedFriends: Set<String>
    let friends: [Friend]
    let toSplit: Bool

    var totalAmount: Double {
        if toSplit {
            return selectedFriends.count > 0 ? amount / Double(selectedFriends.count) : 0
        } else {
            return amount
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(friends, id: \.email) { friend in
                    Button(action: {
                        if selectedFriends.contains(friend.email) {
                            selectedFriends.remove(friend.email)
                        } else {
                            selectedFriends.insert(friend.email)
                        }
                    }) {
                        HStack {
                            Text(friend.name)
                            if selectedFriends.contains(friend.email) {
                                Text(" $ \(totalAmount, specifier: "%.2f")")
                            }
                        }
                        .font(.headline)
                        .foregroundColor(ColorUtils.textColour)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(selectedFriends.contains(friend.email) ? Color.green : ColorUtils.buttonBackgroundColour)
                        .shadow(radius: 10)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
