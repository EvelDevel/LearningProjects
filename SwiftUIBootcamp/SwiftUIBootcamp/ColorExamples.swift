//
//  ColorExamples.swift
//  SwiftUIBootcamp
//
//  Created by Евгений Никитин on 22.10.2023.
//

import SwiftUI

struct ColorExamples: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                Color(uiColor: UIColor.secondarySystemBackground )
            )
            .frame(width: 300, height: 200)
    }
}

struct ColorExamples_Previews: PreviewProvider {
    static var previews: some View {
        ColorExamples()
    }
}
