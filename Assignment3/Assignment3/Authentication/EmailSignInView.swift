//
//  EmailSignInView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI

final class EmailSignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        // Add validation here
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        guard password.count > 5 else {
            print("Password is too short")
            return
        }
        
        Task {
            do {
                let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnUserData)
            } catch {
                print("Error \(error)")
            }
        }
    }
}

struct EmailSignInView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var viewModel = EmailSignInViewModel()
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                TextField("Email...", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                SecureField("Password...", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                Button {
                    viewModel.signIn()
                } label: {
                    Text("Sign In With Email")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Sign In With Email")
    }
}

struct EmailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmailSignInView()
        }
    }
}
