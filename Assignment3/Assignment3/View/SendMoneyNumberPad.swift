//
//  SendMoneyNumberPad.swift
//  Assignment3
//
//  Created by Nick Forgione on 13/5/2023.
//

import SwiftUI

struct SendMoneyNumberPad: View {
    @State private var amount = ""
    @State private var amountDouble = 0.0
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(){
                Text(amount)
                Spacer()
                //Number Pad
                HStack(){
                    // 1 Number Button
                    Spacer()
                    Button(action: {
                        amount = amount + "1"
                    }) {
                        Text("1")
                    }
                    Spacer()
                    // 2 Number Button
                    Button(action: {
                        amount = amount + "2"
                    }) {
                        Text("2")
                    }
                    Spacer()
                    // 3 Number Button
                    Button(action: {
                        amount = amount + "3"
                    }) {
                        Text("3")
                    }
                    Spacer()
                }
                HStack(){
                    Spacer()
                    // 4 Number Button
                    Button(action: {
                        amount = amount + "4"
                    }) {
                        Text("4")
                    }
                    Spacer()
                    // 5 Number Button
                    Button(action: {
                        amount = amount + "5"
                    }) {
                        Text("5")
                    }
                    Spacer()
                    // 6 Number Button
                    Button(action: {
                        amount = amount + "6"
                    }) {
                        Text("6")
                    }
                    Spacer()
                }
                HStack(){
                    Spacer()
                    // 7 Number Button
                    Button(action: {
                        amount = amount + "7"
                    }) {
                        Text("7")
                    }
                    Spacer()
                    // 8 Number Button
                    Button(action: {
                        amount = amount + "8"
                    }) {
                        Text("8")
                    }
                    Spacer()
                    // 9 Number Button
                    Button(action: {
                        amount = amount + "9"
                    }) {
                        Text("9")
                    }
                    Spacer()
                }
                HStack(){
                    Spacer()
                    // . Number Button
                    Button(action: {
                        amount = amount + "."
                    }) {
                        Text(".")
                    }
                    Spacer()
                    // 0 Number Button
                    Button(action: {
                        amount = amount + "0"
                    }) {
                        Text("0")
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    struct SendMoneyNumberPad_Previews: PreviewProvider {
        static var previews: some View {
            SendMoneyNumberPad()
        }
    }
}
