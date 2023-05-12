//
//  AuthenticationView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    var body: some View {
            ZStack {
                ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink {
                        EmailSignInView(showSignInView: $showSignInView)
                    } label: {
                        Text("Sign In With Email")
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
            .navigationTitle("Sign In")
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }

    }
}
