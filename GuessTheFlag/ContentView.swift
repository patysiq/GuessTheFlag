//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by PATRICIA S SIQUEIRA on 05/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var animationCorrect = false
    @State private var animationAmount = Double.zero
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var number = 0
    
    var body: some View {
        ZStack {
            //Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .center, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 50) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.title2)
                
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.number = number
                    })
                    {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .black, radius: 20)
                            .rotation3DEffect(.degrees(animationCorrect && number == correctAnswer ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                            .opacity(animationCorrect && number != correctAnswer ? 0.25 : 1)
                            .animation(.default)
                    }
                }
                VStack {
                    Text("Your score is \(score)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            animationCorrect = true
            animationAmount += 360
        } else {
            scoreTitle = "Wrong. That’s the flag of \(countries[self.number])."
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        animationCorrect = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
