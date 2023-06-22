//
//  ColorChangeAnimation.swift
//  Animations
//
//  Created by Евгений Никитин on 21.06.2023.
//

import SwiftUI

struct ColorChangeAnimation: View {
    @State private var enabled = false
    
    var body: some View {
        Button("Tap me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .cyan : .pink)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.default, value: enabled)
    }
}

struct ColorChangeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ColorChangeAnimation()
    }
}
