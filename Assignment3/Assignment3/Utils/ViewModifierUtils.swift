//
//  ButtonUtils.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import Foundation
import SwiftUI

struct HeadingLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.black)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal)
    }
}

struct SubHeadingLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.black)
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

extension View {
    func headingLabelStyle() -> some View {
        self.modifier(HeadingLabelStyle())
    }
    
    func subHeadingLabelStyle() -> some View {
        self.modifier(SubHeadingLabelStyle())
    }
    
    func textFieldStyle() -> some View {
        self.modifier(TextFieldStyle())
    }
}
