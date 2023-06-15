//
//  ListView.swift
//  WordScramble
//
//  Created by Евгений Никитин on 15.06.2023.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List {
            Text("First static line")
            Text("Second static line")
            
            Section("Section in list") {
                Text("Section line")
                Text("Section line two")
            }
            
            Section("Section with foreach") {
                ForEach(1..<6) {
                    Text("ForEach row #\($0)")
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
