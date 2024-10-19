//
//  PencilShape.swift
//  drawingapp
//
//  Created by Tech Guy on 10/9/24.
//

import SwiftUI

struct PencilShape: View {
    var color: Color
    var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Pencil Tip (Triangle)
            Triangle()
                .fill(Color.gray)
                .frame(width: 30, height: 30)
            
            // Pencil Body (Rectangle)
            RoundedRectangle(cornerRadius: 0)
                .fill(color)
                .frame(width: 30, height: 60)
        }
        .scaleEffect(isSelected ? 1.2 : 1.0) // Pop-out effect using scale on the entire pencil
        .shadow(radius: isSelected ? 10 : 0) // Optional shadow for selected pencil
        .animation(.spring(), value: isSelected) // Smooth pop-out animation
        .padding(5)
    }
}


