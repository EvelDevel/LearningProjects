//
//  TextBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by Евгений Никитин on 21.10.2023.
//

import SwiftUI

struct TextExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, World!")
                .font(.body)
                .bold()
                .underline(true, color: .accentColor)
            
            Text("System text for example")
                .font(
                    .system(
                        size: 16,
                        weight: .heavy,
                        design: .serif
                    )
                )
        }
    }
}

struct TextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextExamples()
    }
}
