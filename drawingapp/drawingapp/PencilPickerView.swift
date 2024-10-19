//
//  SwiftUIView.swift
//  drawingapp
//
//  Created by Tech Guy on 10/9/24.
//

import SwiftUI

struct PencilPicker: View {
    @Binding var currentColor: Color
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .black]
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                PencilShape(color: color, isSelected: currentColor == color)
                    .onTapGesture {
                        withAnimation {
                            currentColor = color
                        }
                    }
            }
        }
        .padding()
    }
}
