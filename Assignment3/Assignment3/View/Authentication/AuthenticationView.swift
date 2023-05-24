//
//  AuthenticationView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = AuthenticationViewModel()
    var body: some View {
            ZStack {
                ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack(spacing:35) {
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .shadow(radius: 20)
                    Text("Split Mate")
                        .font(.custom("System", size: 50))
                        .foregroundColor(.black)
                    Button{
                        Task {
                            do {
                                try await viewModel.signInGoogle()
                                showSignInView = false
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        HStack {
                            Image("GoogleLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)// SF Symbols image
                            Text("Sign In With Google")
                                .font(.headline)
                                .foregroundColor(ColorUtils.textColour)
                        }
                        .headingLabelStyle()
  
                    }
                    NavigationLink {
                        EmailSignInView(showSignInView: $showSignInView)
                    } label: {
                        Text("Sign In With Email")
                            .headingLabelStyle()
                    }
                    Spacer()
                }
            }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }

    }
}
