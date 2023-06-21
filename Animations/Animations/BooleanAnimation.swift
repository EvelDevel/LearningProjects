//
//  BooleanAnimation.swift
//  Animations
//
//  Created by Евгений Никитин on 21.06.2023.
//

import SwiftUI

struct BooleanAnimation: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            Stepper(
                "Scale amount",
                value: $animationAmount.animation(), // Animation inside a value
                in: 1...10
            )
            .padding(20)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct BooleanAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BooleanAnimation()
    }
}
