//
//  BadgeSymbol.swift
//  Landmarks
//
//  Created by Евгений Никитин on 02.10.2022.
//

import SwiftUI

struct BadgeSymbol: View {
    static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let height = width * 0.75131231
                let spacing = width * 0.030131231
                let middle = width * 0.5131231
                let topWidth = width * 0.226131231
                let topHeight = height * 0.488131231
                
                path.addLines([
                    CGPoint(
                        x: middle,
                        y: spacing
                    ),
                    CGPoint(
                        x: middle - topWidth,
                        y: topHeight - spacing
                    ),
                    CGPoint(
                        x: middle,
                        y: topHeight / 2 + spacing
                    ),
                    CGPoint(
                        x: middle + topWidth,
                        y: topHeight - spacing
                    ),
                    CGPoint(
                        x: middle,
                        y: spacing
                    )
                ])
                
                path.move(
                    to: CGPoint(
                        x: middle,
                        y: topHeight / 2 + spacing * 3
                    )
                )
                
                path.addLines([
                    CGPoint(
                        x: middle - topWidth,
                        y: topHeight + spacing
                    ),
                    CGPoint(
                        x: spacing,
                        y: height - spacing
                    ),
                    CGPoint(
                        x: width - spacing,
                        y: height - spacing
                    ),
                    CGPoint(
                        x: middle + topWidth,
                        y: topHeight + spacing
                    ),
                    CGPoint(
                        x: middle,
                        y: topHeight / 2 + spacing * 3
                    )
                ])
            }
            
            .fill(Self.symbolColor)
        }
    }
}

struct BadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        BadgeSymbol()
    }
}
