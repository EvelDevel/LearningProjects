//
//  ColorPractice.swift
//  WeSplit
//
//  Created by Евгений Никитин on 05.04.2023.
//

import SwiftUI

struct ColorPractice: View {
    var body: some View {
        Group {
            ZStack {
                VStack(spacing: 0) {
                    Color.indigo
                    Color.mint
                }
                .ignoresSafeArea()
                
                Text("Hello")
                    .foregroundStyle(.secondary)
                    .padding(50)
                    .cornerRadius(50  )
                    .background(.ultraThinMaterial)
            }
            
            VStack {
                Button("Button 1") {}
                    .buttonStyle(.bordered)
                
                Button("Button 2", role: .destructive) {}
                    .buttonStyle(.bordered)
                
                Button("Button 3") {}
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                
                Button("Button 4", role: .destructive) {}
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct ColorPractice_Previews: PreviewProvider {
    static var previews: some View {
        ColorPractice()
    }
}
