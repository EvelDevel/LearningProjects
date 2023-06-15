//
//  ContentView.swift
//  WordScramble
//
//  Created by Евгений Никитин on 15.06.2023.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                        .focused($isFocused)
                        .autocorrectionDisabled(true)
                }
                
                Section("Score") {
                    Text("Your score is: \(score)")
                        .font(.headline)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle("Word: \(rootWord)")
            .navigationBarTitleDisplayMode(.large)
            .onSubmit {
                addNewWord()
            }
            .onAppear(
                perform: startGame
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Restart") {
                        startGame()
                    }
                    .foregroundColor(.black)
                }
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {
                    isFocused = true
                    newWord = ""
                }
            } message: {
                Text(errorMessage)
            }
        }
    }
}

// MARK: - Game

extension ContentView {
    func startGame() {
        if let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? ""
                usedWords = []
                score = 0
                isFocused = true
                return
            }
        }
        
        fatalError("Could nont load the bundle start.txt")
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard isMoreThanThreeLetter(word: answer) else {
            wordError(
                title: "The word is too small",
                message: "Use more than three letters"
            )
            return
        }
        
        guard isNotOurStartWord(word: answer) else {
            wordError(
                title: "Its our start word",
                message: "Be more original"
            )
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(
                title: "Word used already",
                message: "Be more original"
            )
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(
                title: "Word not possible",
                message: "You can't spell that word from '\(rootWord)'!"
            )
            return
        }
        
        guard isReal(word: answer) else {
            wordError(
                title: "Word not recognized",
                message: "You can't just make them up, you know!"
            )
            return
        }
        
        guard answer.count > 0 else {
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        score += newWord.count
        isFocused = true
        newWord = ""        
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

// MARK: - Validation

extension ContentView {
    private func isMoreThanThreeLetter(word: String) -> Bool {
        word.count >= 3
    }
    
    private func isNotOurStartWord(word: String) -> Bool {
        rootWord != word
    }
    
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        
        return misspelledRange.location == NSNotFound
    }
}

// MARK: - Previws

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
