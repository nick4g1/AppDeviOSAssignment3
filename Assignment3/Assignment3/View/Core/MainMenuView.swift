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
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .shadow(radius: 20)
                Text("Split Mate")
                    .font(.custom("Quicksand-Regular", size: 50))
                    .foregroundColor(ColorUtils.textColour)

                NavigationLink {
                    SplitView()
                } label: {
                    HStack {
                        Text("Split")
                            .font(.title2)
                            .foregroundColor(.white)
                        Image(systemName: "divide.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)

                    }
                    .coloredLabelStyle(Color(red: 0.15, green: 0.36, blue: 0.49))
                }
                NavigationLink {
                    // Link to request view
                    RequestView()
                } label: {
                    HStack {
                        Text("Request")
                            .font(.title2)
                            .foregroundColor(.white)
                        Image(systemName: "dollarsign.arrow.circlepath")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                    }
                    .coloredLabelStyle(Color(red: 0.08, green: 0.4, blue: 0.52))
                }
                NavigationLink {
                    SendMoneyView()
                } label: {
                    HStack {
                        Text("Send")
                            .font(.title2)
                            .foregroundColor(.white)
                        Image(systemName: "paperplane.circle")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                    }
                    .coloredLabelStyle(Color(red: 0, green: 0.46, blue: 0.60))
                }
                NavigationLink {
                    TrackView()
                } label: {
                    HStack {
                        Text("Track")
                            .font(.title2)
                            .foregroundColor(.white)
                        Image(systemName: "list.clipboard.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                    }
                    .coloredLabelStyle(Color(red: 0.35, green: 0.6, blue: 0.75))
                }
                NavigationLink {
                    ProfileView()
                } label: {
                    HStack {
                        Text("Profile")
                            .font(.title2)
                            .foregroundColor(.white)
                        Image(systemName: "person.circle")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                    }
                    .coloredLabelStyle(Color(red: 0.56, green: 0.76, blue: 0.91))
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
                    HStack {
                        Text("Logout")
                            .font(.title2)
                            .foregroundColor(.black)
                        Image(systemName: "nosign")
                            .resizable()
                            .foregroundColor(.black)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                    }
                        .headingLabelStyle()
                }
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainMenuView(showSignInView: .constant(false))
        }

    }
}
