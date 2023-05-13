//
//  MainMenuView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI

struct MainMenuView: View {
    @Binding var showSignInView: Bool
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Spacer()
                NavigationLink {
                    // Link to split view
                } label: {
                    Text("Split")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 300)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                }
                NavigationLink {
                    // Link to request view
                    RequestView()
                } label: {
                    Text("Request")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 300)
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                }
                NavigationLink {
                    // Link to send view
                } label: {
                    Text("Send")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 300)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                }
                NavigationLink {
                    // Link to track view
                } label: {
                    Text("Track")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 300)
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                }
                NavigationLink {
                    // Link to profile view
                } label: {
                    Text("Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 300)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                }
                Button {
                    Task {
                        do {
                            try AuthenticationManager.shared.signOut()
                            showSignInView = true
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                }
            }
        }
        .navigationTitle("Split Mate")
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainMenuView(showSignInView: .constant(false))
        }

    }
}
