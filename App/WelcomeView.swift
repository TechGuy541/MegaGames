//
//  WelcomeView.swift
//  MegaGames
//
//  Created by Tech Guy on 10/15/24.
//

import SwiftUI

struct WelcomeView: View {
    // State to track if the user has pressed continue
    @AppStorage("hasSeenWelcome") private var hasContinued: Bool = false

    var body: some View {
        if hasContinued {
            // Navigate to the main content view when "Continue" is pressed
            ContentView()
        } else {
            VStack(spacing: 20) {
                // Display the app description
                Text("Welcome to MegaGames")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                ScrollView {
                    Text("""
                    **MegaGames**, the ultimate collection of fun and addictive mini-games! Whether you’re a fan of fast-paced action or want to unleash your creativity, **MegaGames** has something for everyone. Enjoy a selection of classic, retro-inspired games, including:

                    🎮 **Flappy Bird**: Test your reflexes by guiding the bird through endless pipes in this arcade favorite.
                    🦖 **Dino Run**: Jump over cacti in this simple yet thrilling endless runner game!
                    🚁 **Retro Helicopter**: Take control of a helicopter and avoid blocks in this challenge.
                    🌍 **Wordle**: A fun word quiz! Guess the word using the clues given.
                    🏎️ **Smash Karts**: Fast-paced multiplayer kart game where you fight to see who can kill the most.
                    🖌️ **Draw & Create**: Let your imagination run wild with our built-in drawing feature.
                        **And more**: even more games and things to enjoy
                    """)
                    .padding()
                    .font(.body)
                    .multilineTextAlignment(.leading)
                }

                // Continue button
                Button(action: {
                    // Set hasContinued to true to move to the main view
                    hasContinued = true
                }) {
                    Text("Continue")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

