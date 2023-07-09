//
//  ContentView.swift
//  WordScramble
//
//  Created by Akash Sheelavant on 06/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = "Hello"
    @State private var newWord = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter a word", text: $newWord)
                        .textInputAutocapitalization(.none)
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
            .navigationTitle(rootWord)
        }
        .onSubmit {
            addNewWord()
        }
        .onAppear {
            startGame()
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "star", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
