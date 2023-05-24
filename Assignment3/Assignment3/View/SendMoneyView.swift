//
//  SendMoneyView.swift
//  Assignment3
//
//  Created by Nick Forgione on 13/5/2023.
//

import SwiftUI

struct SendMoneyView: View {
    @State private var value = 0.0
    private var numberFormatter: NumberFormatter
    //Friends
    @State private var selectedFriends: Set<String> = []
    let friends = Friends().generateFriends()
    //Initialize number formatter for CurrencyTextField
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
            self.numberFormatter = numberFormatter
        self.numberFormatter.numberStyle = .currency
            self.numberFormatter.maximumFractionDigits = 2
    }
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(){
                //Title as navigation title
                //Creates text field using CurrencyTextField and NumberFormatter initialized above
                CurrencyTextField(numberFormatter: numberFormatter, value: $value)
                                .padding(20)
                                .overlay(RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 2))
                                .frame(height: 100)
                Spacer()
                Text("Friend List").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 30)).padding(.all)
                // Here comes the scrollstack
                FriendsScrollView(amount: $value, selectedFriends: $selectedFriends, friends: friends, toSplit: false)
                Spacer()
                //Link to confirmation view
                NavigationLink(
                    destination: ConfirmationView(amount: $value),
                    label: {
                        Text("Send")
                            .sendReceiveStyle()
                    }
                )
                //Check to make sure value is properly created
                Text(String(format: "Sending: $%.02f", value))
            }
            .navigationTitle("Send Money")
        }
    }
    
    struct SendMoneyView_Previews: PreviewProvider {
        static var previews: some View {
            SendMoneyView()
        }
    }
}
