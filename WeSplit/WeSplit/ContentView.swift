//
//  ContentView.swift
//  WeSplit
//
//  Created by Евгений Никитин on 03.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    @State private var selectedStudent = "Harry"
    
    let students = ["Harry", "Hermione", "Ron"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
        }

        // Form {
        //     Group {
        //         Button("Tap Count: \(tapCount)") {
        //             tapCount += 1
        //         }
        //
        //         Section {
        //             TextField("Enter your name", text: $name)
        //             Text("Your name is \(name)")
        //         }
        //     }
        // }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
