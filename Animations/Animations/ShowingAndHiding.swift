//
//  ShowingAndHiding.swift
//  Animations
//
//  Created by Евгений Никитин on 22.06.2023.
//

import SwiftUI

struct ShowingAndHiding: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ShowingAndHiding_Previews: PreviewProvider {
    static var previews: some View {
        ShowingAndHiding()
    }
}
