//
//  TextFieldStyling.swift
//  multiMessager
//
//  Created by Jordan Davis on 2023-02-12.
//

import SwiftUI

struct TextFieldStyling: ViewModifier {
    func body(content: Content) -> some View {
        let luxuryBackground = Color(red: 0.9, green: 0.9, blue: 0.9)
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(luxuryBackground)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .multilineTextAlignment(.leading)
            
    }
}

extension View {
    func textFieldStyling() -> some View {
        self.modifier(TextFieldStyling())
    }
}
