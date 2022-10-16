//
//  test.swift
//  Landmarks
//
//  Created by Евгений Никитин on 16.10.2022.
//

import SwiftUI

struct test: View {
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path(ellipseIn: CGRect(origin: .zero, size: size)),
                with: .color(.yellow),
                lineWidth: 2)
            
            let halfSize = size.applying(
                CGAffineTransform(
                    scaleX: 0.5,
                    y: 0.5
                )
            )
            
            context.clip(to: Path(CGRect(origin: .zero, size: halfSize)))
            context.fill(
                Path(ellipseIn: CGRect(origin: .zero, size: size)),
                with: .color(.green))
        }
        .frame(width: 300, height: 200)
        .border(Color.brown)
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
