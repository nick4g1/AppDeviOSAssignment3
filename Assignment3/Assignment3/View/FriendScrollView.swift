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
    
    var totalAmount: Double {
        selectedFriends.count > 0 ? amount / Double(selectedFriends.count) : 0
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
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(selectedFriends.contains(friend.email) ? Color.green : Color.black)
                        .shadow(radius: 10)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
