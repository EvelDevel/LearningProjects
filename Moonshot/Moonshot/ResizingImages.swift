//
//  ResizingImages.swift
//  Moonshot
//
//  Created by Евгений Никитин on 22.07.2023.
//

import SwiftUI

struct ResizingImages: View {
    var body: some View {
        Image("young")
            .frame(width: 300, height: 100)
            .clipped()  
    }
}

struct ResizingImages_Previews: PreviewProvider {
    static var previews: some View {
        ResizingImages()
    }
}
