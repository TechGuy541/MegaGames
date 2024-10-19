//
//  WebView.swift
//  App
//
//  Created by Tech Guy on 10/11/24.
//

import SwiftUI
import WebKit

// WebViewWrapper to embed WKWebView inside SwiftUI
import SwiftUI
import WebKit

// WebView Wrapper using UIViewRepresentable
import SwiftUI
import WebKit

struct WebView1: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // Disable user action requirement for media playback
        webView.configuration.mediaPlaybackRequiresUserAction = false
        
        // Set additional media settings if required
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.allowsAirPlayForMediaPlayback = true
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Handle updates if needed
    }
}

struct SecretWebView: View {
    var body: some View {
        let urlString = "https://smashkarts.io"
        
        // Convert String to URL safely
        if let url = URL(string: urlString) {
            WebView1(url: url) // Pass URL to WebView
                .edgesIgnoringSafeArea(.all)
                .toolbar(.hidden, for: .tabBar)// Ensure it covers the whole screen
        } else {
            Text("Invalid URL") // Makes the web view fill the screen, adjust as needed
        }
    }
}

struct RetroWebView: View {
    var body: some View {
        let urlString = "https://www.coolxgames.com/sites/default/files/public_games/127/"
        
        // Convert String to URL safely
        if let url = URL(string: urlString) {
            WebView1(url: url) // Pass URL to WebView
                .edgesIgnoringSafeArea(.all)
                .toolbar(.hidden, for: .tabBar)// Ensure it covers the whole screen
        } else {
            Text("Invalid URL") // Makes the web view fill the screen, adjust as needed
        }
    }
}
struct RunWebView: View {
    var body: some View {
        let urlString = "https://www.coolmathgames.com/0-run-3/play"
        
        // Convert String to URL safely
        if let url = URL(string: urlString) {
            WebView1(url: url) // Pass URL to WebView
                .edgesIgnoringSafeArea(.all)
                .toolbar(.hidden, for: .tabBar)// Ensure it covers the whole screen
        } else {
            Text("Invalid URL") // Makes the web view fill the screen, adjust as needed
        }
    }
}
