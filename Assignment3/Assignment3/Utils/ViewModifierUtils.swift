//
//  ButtonUtils.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import Foundation
import SwiftUI

// Various structs to represent different ViewModifiers used throughout app

struct HeadingLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(ColorUtils.textColour)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(ColorUtils.buttonBackgroundColour)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal)
    }
}

struct ColoredLabelStyle: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(ColorUtils.textColour)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal)
    }
}

struct AlternateLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(ColorUtils.buttonBackgroundColour)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.7, green: 0.7, blue: 0.7))
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal)
    }
}

struct ConfirmLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(ColorUtils.textColour)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.green)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal)
    }
}

struct SendReceiveLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: 300)
            .background(Color.green)
            .cornerRadius(10)
            .shadow(radius: 20)
            .padding(.horizontal)
    }
}

struct SubHeadingLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(ColorUtils.textColour)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(ColorUtils.backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal)
    }
}

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(10)
            .padding(.horizontal)
            .autocapitalization(.none)
    }
}

struct NumberFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(.title)
            .frame(height: 55)
            .foregroundColor(Color(red: 0.3, green: 0.5, blue: 0.3))
            .frame(maxWidth: 150)
            .padding(.horizontal)
            .keyboardType(.decimalPad)
    }
}

extension View {
    func headingLabelStyle() -> some View {
        self.modifier(HeadingLabelStyle())
    }
    
    func coloredLabelStyle(_ color: Color) -> some View {
        self.modifier(ColoredLabelStyle(color: color))
    }
    
    func alternatelabelStyle() -> some View {
        self.modifier(AlternateLabelStyle())
    }
    
    func subHeadingLabelStyle() -> some View {
        self.modifier(SubHeadingLabelStyle())
    }
    
    func textFieldStyle() -> some View {
        self.modifier(TextFieldStyle())
    }
    func sendReceiveStyle() -> some View {
        self.modifier(SendReceiveLabelStyle())
    }
    
    func confirmLabelStyle() -> some View {
        self.modifier(ConfirmLabelStyle())
    }
    
    func numberFieldStyle() -> some View {
        self.modifier(NumberFieldStyle())
    }

}
