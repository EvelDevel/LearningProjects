//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Евгений Никитин on 17.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ].shuffled()
    
    var body: some View {
        ZStack {
            // LinearGradient(
            //     gradient: Gradient(
            //         colors: [.indigo, .black]
            //     ),
            //     startPoint: .top,
            //     endPoint: .bottom
            // )
            //     .ignoresSafeArea()
            
            RadialGradient(
                stops: [
                    .init(
                        color: Color(
                            red: 0.1,
                            green: 0.2,
                            blue: 0.45
                        ),
                        location: 0.3
                    ),
                    .init(
                        color: Color(
                            red: 0.76,
                            green: 0.15,
                            blue: 0.26
                        ),
                        location: 0.3
                    )
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(
                                    cornerRadius: 8,
                                    style: .continuous
                                ))
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(minWidth: 270)
                .padding(.vertical, 35)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
            
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
        }
        
        // .alert(scoreTitle, isPresented: $showingScore) {
        //     Button("Continue", action: askQuestion)
        // } message: {
        //     Text("Your score is \(score)")
        // }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            askQuestion()
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
