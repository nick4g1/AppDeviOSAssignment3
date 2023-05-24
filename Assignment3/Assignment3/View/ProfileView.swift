//
//  ProfileView.swift
//  Split Mate
//
//  Created by Jake Isaacs on 22/5/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileModel()
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserID: \(user.userId)")
                Text("Balance: \(user.balance)")
                Button {
                    Task {
                        try? await UserManager.shared.requestMoney(amount: 100, email: "cooper")
                        try? await UserManager.shared.addFriend(friendEmail: "cooper@gmail.com")
                        try? await viewModel.loadUser()
                    }
                    
                } label: {
                    Text("Increase Balance")
                }
            }

        }
            .task {
                try? await viewModel.loadUser()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
