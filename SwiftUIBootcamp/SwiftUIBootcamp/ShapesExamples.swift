//
//  ShapesExamples.swift
//  SwiftUIBootcamp
//
//  Created by Евгений Никитин on 22.10.2023.
//

import SwiftUI

struct ShapesExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .fill(.pink)
            
            Capsule()
                .strokeBorder(
                    Color.cyan,
                    style: StrokeStyle(
                        lineWidth: 3,
                        lineCap: .round,
                        dash: [10]
                    )
                )
            
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .strokeBorder(
                    Color.green,
                    style: StrokeStyle(
                        lineWidth: 3,
                        lineCap: .round
                    )
                )
        }
        .padding(20)
    }
}

struct ShapesExamples_Previews: PreviewProvider {
    static var previews: some View {
        ShapesExamples()
    }
}
