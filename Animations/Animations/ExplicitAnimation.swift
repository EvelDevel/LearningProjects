//
//  ExplicitAnimation.swift
//  Animations
//
//  Created by Евгений Никитин on 21.06.2023.
//

import SwiftUI

struct ExplicitAnimation: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(
                .interpolatingSpring(
                    stiffness: 20,
                    damping: 5
                )
            ) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (
                x: 0,
                y: 1,
                z: 0
            )
        )
    }
}

struct ExplicitAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimation()
    }
}
