//
//  ContentView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 9/5/2023.
//

import SwiftUI
import GoogleSignInSwift

struct ContentView: View {

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isNavigating: Bool = false
    var body: some View {
        ZStack {
            Color(red: 0.4, green: 0.4, blue: 0.4).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Split | Mate")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top)
                Spacer()
                GoogleSignInButton(action: {
                print("Signed in")})
                .padding(.all)
                .padding(.bottom)
            }
        }
    }
}

struct NextView: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
