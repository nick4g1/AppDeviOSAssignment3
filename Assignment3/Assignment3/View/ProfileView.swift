//
//  ProfileView.swift
//  Split Mate
//
//  Created by Jake Isaacs on 22/5/2023.
//

import SwiftUI

struct ProfileView: View {

    // Accessing the current user
    @StateObject private var viewModel = ProfileModel()


    var body: some View {
        ZStack {
            // Background colour
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            List {
                if var user = viewModel.user {
                    // Check that the photoUrl is not nil
                    if let photoUrl = viewModel.user?.photoUrl {
                        Image("Profile Photo")
                            .data(url: URL(string: photoUrl)!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        // Choose system image if photoUrl is nil
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    // Text fields that access data from firebase, and return empty strings if nil
                    Text("UserID: \(user.userId)")
                    // Add TextField for Username
                    TextField("Name:", text: $viewModel.name)
                    Text("Email: \(user.email)")
                    Text("Date Created: \(user.dateCreated.formatted())")
                    Button("Update Profile") {
                        Task {
                            user.name = viewModel.name
                            try? await UserManager.shared.updateProfile(user: user)
                        }
                    }
                    Section(header: Text("Friends")) {
                        VStack(spacing: 10) {
                            ForEach(user.friends, id: \.self) { friend in
                                Text(friend)
                                    .foregroundColor(ColorUtils.textColour)
                                    .frame(height: 35)
                                    .frame(maxWidth: .infinity)
                                    .background(ColorUtils.buttonBackgroundColour)
                                    .shadow(radius: 10)
                                    .cornerRadius(10)
                            }

                        }
                        TextField("Add Friend:", text: $viewModel.friendToAdd)
                        Button("Add Friend") {
                            Task {
                                if !viewModel.friendToAdd.isEmpty {
                                    try? await UserManager.shared.addFriend(friendEmail: viewModel.friendToAdd)
                                    try? await viewModel.loadUser()
                                }
                            }
                        }


                    }
                }

            }
            // Load the current user from the UserManager
            .task {
                try? await viewModel.loadUser()
            }
        }
            .navigationTitle("Profile")
    }

}

// An extension to the Image class to check the data coming from firebase
// Adds a data function that tries the data from the URL
// If it succeeds, return the profile picture from authentication
// If it fails, return the default system image "person.circle.fill"
extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return Image(systemName: "person.circle.fill")
            .resizable()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
