//
//  DragGestures.swift
//  Animations
//
//  Created by Евгений Никитин on 22.06.2023.
//

import SwiftUI

struct DragGestures: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [.yellow, .red]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(width: 300, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(dragAmount)
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    withAnimation {
                        dragAmount = .zero
                    }
                }
        )
    }
}

struct DragGestures_Previews: PreviewProvider {
    static var previews: some View {
        DragGestures()
    }
}
