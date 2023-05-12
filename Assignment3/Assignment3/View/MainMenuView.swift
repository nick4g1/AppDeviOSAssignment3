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
            VStack {
                Spacer()
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
        .navigationTitle("Main Menu")
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainMenuView(showSignInView: .constant(false))
        }

    }
}
