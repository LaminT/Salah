//
//  Modifiers.swift
//  Salahtider
//
//  Created by Lamin Tamba on 03/11/2020.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(1)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
    }
}

struct FontModifier: ViewModifier {
    var style: Font.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .rounded))
    }
}

struct BottomCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top, 8)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(30)
            .shadow(radius: 20)
    }
}


