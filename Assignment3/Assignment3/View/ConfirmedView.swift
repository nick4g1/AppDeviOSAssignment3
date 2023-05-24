//
//  ConfirmedView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

struct ConfirmedView: View {
    @Binding var amount: Double
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)

            VStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 200))
                    .foregroundColor(.green)
                    .shadow(radius: 10)
                    .frame(maxHeight: UIScreen.main.bounds.height / 2)

				Text("Your transaction of \(amount, format: .currency(code: "AUD")) has been excuted")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                Spacer()

                NavigationLink {
                    MainMenuView(showSignInView: .constant(false))
                } label: {
                    Text("Main Menu")
                        .headingLabelStyle()
                }

            }
        }
    }
}

struct ConfirmedView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmedView(amount: .constant(0.0))
    }
}
