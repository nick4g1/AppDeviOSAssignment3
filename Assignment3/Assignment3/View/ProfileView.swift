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
            ZStack {
                ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    List {
                        // Image(viewModel.user?.photoUrl ?? "") // Image from AUTH
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(50)
                        Text("Name: \(viewModel.user?.uid ?? "")") // Currently ID from AUTH
                        Text("Phone: 111") // Will be from Firestore when set up
                        Text("Email: \(viewModel.user?.email ?? "")") // Currently email from AUTH
                    }
                    .onAppear {
                        try? viewModel.loadCurrentUser()
                    }
                }
            }
            .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
