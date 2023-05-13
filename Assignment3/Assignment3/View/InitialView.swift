//
//  InitialView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI

struct InitialView: View {
    
    // Declaring boolean that will indicates whether sign in view should be shown if no user
    // is logged in or if main menu should be shown if user logged in already
    @State private var showSignInView: Bool = false
    
    var body: some View {
        
        //Inital view shows the menu view if user is signed in and passes that binding to the view
        ZStack {
            if !showSignInView {
                NavigationStack {
                    MainMenuView(showSignInView: $showSignInView)
            }
           
            }
        }
        // When view appears tries to retrieve signed in user from local storage
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            // If user can't be retrieved show the signin view
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }

    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
