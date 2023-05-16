//
//  ProfileView.swift
//  Split Mate
//
//  Created by Cooper Jacob on 13/5/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileModel()
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserID: \(user.uid)")
            }

        }
            .onAppear {
                try? viewModel.loadCurrentUser()
    }

        }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
