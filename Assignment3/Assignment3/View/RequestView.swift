//
//  RequestView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

struct RequestView: View {
    //@Binding private var passTotalAmount = 0.0
    //@State private var selectedPage: Page = RequestView()
    @State private var amount = 0.0
    @State private var selectedFriends: Set<String> = []
    let friends = Friends().generateFriends()
    
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("REQUEST")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Text("ENTER AN AMOUNT")
//                    .frame(maxWidth: .leading)

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    //.foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: 400)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .keyboardType(.decimalPad)
                // Here comes the scrollstack
                FriendsScrollView(amount: $amount, selectedFriends: $selectedFriends, friends: friends)
                //
                Spacer()
                NavigationLink(
                    destination: ConfirmationView(amount: $amount),
                    label: {
                        Text("Request")
                            .headingLabelStyle()
                    }
                )

            }

        }
            .navigationTitle("REQUEST")
        
        
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
