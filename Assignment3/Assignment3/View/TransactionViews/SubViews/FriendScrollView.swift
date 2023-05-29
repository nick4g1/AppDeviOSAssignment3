//
//  FriendScrollView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 13/5/2023.
//

import SwiftUI

// Scrolling view that is populated with friends from profile
struct FriendsScrollView: View {

    // Bindings for amount of money to send or request and friends that have been selected
    @Binding var amount: Double
    @Binding var selectedFriends: Set<String>
    let friends: [Friend]
    let toSplit: Bool

    // If view is called from Split view, split amount between selection
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
                    
                    // Adds selected friend to selectedFriends set
                    Button(action: {
                        if selectedFriends.contains(friend.email) {
                            selectedFriends.remove(friend.email)
                        } else {
                            selectedFriends.insert(friend.email)
                        }
                    }) {
                        
                        // HStack containing friend name and amount the amount if friend is selected
                        HStack {
                            Text(friend.name)
                            if selectedFriends.contains(friend.email) {
                                Text(" $ \(totalAmount, specifier: "%.2f")")
                            }
                        }
                            .font(.headline)
                            .foregroundColor(ColorUtils.textColour)
                            .frame(height: 35)
                            .frame(maxWidth: .infinity)
                            
                            // Background color changes to green if selected
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
