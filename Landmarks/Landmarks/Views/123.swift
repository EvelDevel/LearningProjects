//
//  123.swift
//  Landmarks
//
//  Created by Евгений Никитин on 02.10.2022.
//

import SwiftUI

struct _23: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 20, y: 0))
            path.addLine(to: CGPoint(x: 20, y: 200))
            path.addLine(to: CGPoint(x: 220, y: 200))
            path.addLine(to: CGPoint(x: 220, y: 0))
        }
        .fill(
            .linearGradient(
                Gradient(colors: [.green, .blue]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.5)
            )
        )
    }
}

struct _23_Previews: PreviewProvider {
    static var previews: some View {
        _23()
    }
}
