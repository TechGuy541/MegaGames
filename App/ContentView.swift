//
//  ContentView.swift
//  App
//
//  Created by Tech Guy on 10/7/24.
//

import SwiftUI
import UIKit
import ComposableArchitecture
import GoogleMobileAds

struct Game: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let view: AnyView
}

struct GameViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameViewController {
        return GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) { }
}

private var mainView: some View {
    let rawValue = UserDefaults.standard.integer(forKey: Notification.Name.gameBoardSize.rawValue)
    let boardSize = BoardSize(rawValue: rawValue) ?? BoardSize.fourByFour
    return CompositeView(board: GameLogic(size: boardSize.rawValue))
}

struct ContentView: View {
    @State private var selectedFile: URL? = nil
    @State private var showAds: Bool = true
    
    let games = [
        Game(name: "Flappy Bird", imageName: "flappy", view: AnyView(GameViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
            .toolbar(.hidden, for: .tabBar))),
        Game(name: "Dino Run", imageName: "dino", view: AnyView(GameView()
            .edgesIgnoringSafeArea(.all)
            .toolbar(.hidden, for: .tabBar))),
        Game(name: "2048", imageName: "2048", view: AnyView(mainView
            .edgesIgnoringSafeArea(.all)
            .toolbar(.hidden, for: .tabBar))),
        Game(name: "Smash Karts", imageName: "web", view: AnyView(SecretWebView()
                                                                 )),
        Game(name: "Retro Helicopter", imageName: "retro", view: AnyView(RetroWebView())),
        Game(name: "Wordle", imageName: "words", view: AnyView(GameViewWords(store: Store(initialState: AppState(), reducer: appReducer, environment: AppEnv()))
            .edgesIgnoringSafeArea(.all)
            .toolbar(.hidden, for: .tabBar)))
    ]
    init() {
            setupTabBarAppearance()
        }
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        TabView {
            GeometryReader { geometry in
                let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(geometry.size.width)
                NavigationStack {
                    VStack {
                        HStack {
                                            Spacer()
                                            Button(action: {
                                                showAds.toggle()
                                            }) {
                                                Text("hello") // Use an icon or leave it invisible
                                                    
                                                    .frame(width: 5, height: 5)
                                                    .foregroundColor(.clear) // Make the icon transparent (hidden)
                                            }
                                            Spacer()
                                        }
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(games) { game in
                                    NavigationLink(destination: game.view) {
                                        VStack {
                                            ZStack {
                                                Image(game.imageName)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 150, height: 150)
                                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                                    .blur(radius: 10)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 30)
                                                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                                    )
                                                Image(game.imageName)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 130, height: 130)
                                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                            }
                                            .frame(width: 150, height: 150)
                                            Text(game.name)
                                                .font(.headline)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 5)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color(white: 0.95))
                                                )
                                                .padding(.top, 8)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        if showAds {
                            BannerView(adSize)
                                .frame(height: adSize.size.height)
                        }
                    }
                    .navigationTitle("Games")

                }
                
                }
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }

               NavigationStack {
                    DrawingView()
                }
                .tabItem {
                    Image(systemName: "pencil.tip")
                    Text("Drawing")
                }
               
        
            }
        
        }
    private func setupTabBarAppearance() {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground() // Set the background to opaque
            appearance.backgroundColor = UIColor.systemBackground // Set background color

            // Apply the appearance to all tab bars
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().standardAppearance = appearance
        }
    }

