//
//  ContentView.swift
//  drawingapp
//
//  Created by Tech Guy on 10/9/24.
//

import SwiftUI

struct DrawingView: View {
    @State private var currentColor: Color = .black
    @State private var lines: [Line] = []
    @State private var currentLine = Line(points: [], color: .black)
    @State private var savedDrawings: [UIImage] = []
    @State private var showGallery = false
    
    var body: some View {
        GeometryReader { geometry in
           
            
            VStack {
                Spacer()
                
                HStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white)
                            .shadow(radius: 10)
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
                .padding(.top, 60)
                    .frame(minWidth: 300, minHeight: 400)
                    
                    
                }
                .padding()
                
                
                    Spacer()
                    
                    PencilPicker(currentColor: $currentColor)
                        .frame(height: 80)
                
                        .padding(.bottom, geometry.size.width > 600 ? 18 : 80)
            }
            
            .padding(.bottom)
            .background(Color.gray.opacity(0.1))
            .edgesIgnoringSafeArea(.all)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                    clearDrawing()
                    }) {
                        Text("Clear")}
                    .padding(.bottom, geometry.size.width > 600 ? 0 : 28)
                    .padding(.leading, 20)
                }
                
                
                
            }
            
            
        }
        
        
        
            
    }
    
    func clearDrawing() {
    lines.removeAll()
    currentLine = Line(points: [], color: currentColor)
    }
        
}
