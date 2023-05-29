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

    // Bool for collapsible section for friends
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            // Background colour
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            List {
                // Load content from user if logged in
                if var user = viewModel.user {
                    
                    // Check that the photoUrl is not nil
                    if let photoUrl = user.photoUrl {
                        Image("Profile Photo")
                            .data(url: URL(string: photoUrl)!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                        // Choose system image if photoUrl is nil
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    }
                    
                    // Text that access data from firebase
                    // Text field for the name that updates when the update profile button is pressed
                    // Aligned in VStacks for a more aesthetic look
                    VStack(alignment: .leading) {
                        Text("UserID") .font(.title2) .bold() .padding(.bottom, 5)
                        Text("\(user.userId)")
                    }
                    VStack(alignment: .leading) {
                        Text("Name") .font(.title2) .bold()
                        TextField("Name:", text: $viewModel.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading) {
                        Text("Email") .font(.title2) .bold() .padding(.bottom, 5)
                        Text("\(user.email)")
                    }
                    VStack(alignment: .leading) {
                        Text("Date Created") .font(.title2) .bold() .padding(.bottom, 5)
                        Text("\(user.dateCreated.formatted())")
                    }
                    
                    // Updates name to the firestore
                    Button("Update Profile") {
                        Task {
                            user.name = viewModel.name
                            try? await UserManager.shared.updateProfile(user: user)
                        }
                    }
                    
                    // Section to access friends from the viewmodel
                    // Grabs each friend and adds them to the display
                    Section() {
                        // Collapsible section in friends
                        DisclosureGroup(isExpanded: $isExpanded) {
                            VStack(spacing: 10) {
                                // Loop through friend array in current user and add to view
                                ForEach(user.friends, id: \.self) { friend in
                                    Text(friend)
                                        .foregroundColor(ColorUtils.textColour)
                                        .frame(height: 35)
                                        .frame(maxWidth: .infinity)
                                        .background(ColorUtils.buttonBackgroundColour)
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.bottom, 10)
                            
                            // text field to add new friend
                            TextField("Add Friend:", text: $viewModel.friendToAdd)
                                .autocapitalization(.none)
                            
                            // If text field is not empty add a new friend to the friend array
                            Button("Add Friend") {
                                Task {
                                    if !viewModel.friendToAdd.isEmpty {
                                        try? await UserManager.shared.addFriend(friendEmail: viewModel.friendToAdd)
                                        try? await viewModel.loadUser()
                                    }
                                }
                            }
                        } label: {
                            // Didn't want a label for aesthetic purposes
                            Text("Friends")
                                .font(.title2)
                                .bold()
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
