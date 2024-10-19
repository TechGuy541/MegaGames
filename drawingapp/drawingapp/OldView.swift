//
//  OldView.swift
//  App
//
//  Created by Léopold on 10/10/24.
//

import SwiftUI


struct OldView: View {
   @State private var currentColor: Color = .black
   @State private var lines: [Line] = []
   @State private var currentLine = Line(points: [], color: .black)
   @State private var savedDrawings: [UIImage] = [] // List to hold saved drawings
   @State private var showGallery = false // Flag to toggle the saved drawings view
   
   var body: some View {
       GeometryReader { geometry in
           let isIpad = UIDevice.current.userInterfaceIdiom == .pad
           
           VStack {
               Spacer() // Push drawing area down to respect top padding
               
               HStack {
                   if isIpad {
                       // Pencils on the left for iPad
                       PencilPicker(currentColor: $currentColor)
                           .frame(width: 80)
                           .padding(.leading, 16) // Give extra space from the left edge
                   }
                   
                   // Drawing Canvas
                   ZStack {
                       RoundedRectangle(cornerRadius: 30) // Rounded corners
                           .fill(Color.white)
                           .shadow(radius: 10) // Optional shadow for elevation
                       //.border(Color.black, width: 2)
                           .gesture(DragGesture(minimumDistance: 0)
                               .onChanged { value in
                                   let newPoint = value.location
                                   currentLine.points.append(newPoint)
                                   currentLine.color = currentColor
                               }
                               .onEnded { _ in
                                   lines.append(currentLine)
                                   currentLine = Line(points: [], color: currentColor)
                               }
                           )
                           
                           .overlay(
                               ForEach(lines) { line in
                                   Path { path in
                                       guard let firstPoint = line.points.first else { return }
                                       path.move(to: firstPoint)
                                       for point in line.points.dropFirst() {
                                           path.addLine(to: point)
                                       }
                                   }
                                   .stroke(line.color, lineWidth: 3)
                               }
                           )
                           .overlay(
                               Path { path in
                                   guard let firstPoint = currentLine.points.first else { return }
                                   path.move(to: firstPoint)
                                   for point in currentLine.points.dropFirst() {
                                       path.addLine(to: point)
                                   }
                               }
                                   .stroke(currentLine.color, lineWidth: 3)
                           )
                   }
                   .padding(.top, 40) // Move the drawing canvas away from the screen borders
                   .frame(minWidth: 300, minHeight: 400) // Adjust size for a more central look
                   
                   if isIpad {
                       Spacer()
                   }
               }
               .padding()
               
               
               
               if !isIpad {
                   // Pencils on the bottom for iPhone
                   PencilPicker(currentColor: $currentColor)
                       .frame(height: 80)
                       .padding(.bottom, geometry.safeAreaInsets.bottom) // Respect iPhone bottom insets
                       .padding(.bottom, 0) // Further spacing from the sides
               }
               
               /*  HStack {
                // Save Button
                Button(action: {
                saveDrawing()
                }) {
                Text("Save")
                .font(.headline)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .foregroundColor(.white)
                }
                .padding(.leading)
                
                // Clear Button
                Button(action: {
                clearDrawing()
                }) {
                Text("Clear")
                .font(.headline)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .foregroundColor(.white)
                }
                
                // Show Saved Drawings
                Button(action: {
                showGallery.toggle()
                }) {
                Text("Gallery")
                .font(.headline)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                }
                .padding(.trailing)
                }
                .padding(.top)
                
                // Show saved drawings in a modal
                .sheet(isPresented: $showGallery) {
                SavedDrawingsView(savedDrawings: $savedDrawings) // Pass binding to savedDrawings
                }
                }
                .padding(.top, geometry.safeAreaInsets.top) // Respect the top inset on iPhones
                }
                .background(Color.gray.opacity(0.1))
                .edgesIgnoringSafeArea(.all)
                }
                
                // Function to save the drawing as an image
                func saveDrawing() {
                let renderer = ImageRenderer(content: ZStack {
                Color.white
                ForEach(lines) { line in
                Path { path in
                guard let firstPoint = line.points.first else { return }
                path.move(to: firstPoint)
                for point in line.points.dropFirst() {
                path.addLine(to: point)
                }
                }
                .stroke(line.color, lineWidth: 3)
                }
                })
                
                if let image = renderer.uiImage {
                savedDrawings.append(image) // Append the image to savedDrawings
                clearDrawing() // Clear the current drawing after saving
                }
                }
                
                // Function to clear the current drawing
                func clearDrawing() {
                lines.removeAll()
                currentLine = Line(points: [], color: currentColor)
                }*/
           }
       }
   }
}
