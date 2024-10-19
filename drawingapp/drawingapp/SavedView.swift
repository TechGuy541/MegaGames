//
//  SavedView.swift
//  drawingapp
//
//  Created by Tech Guy on 10/9/24.
//

import SwiftUI

struct SavedDrawingsView: View {
    @Binding var savedDrawings: [UIImage]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(savedDrawings, id: \.self) { drawing in
                        Image(uiImage: drawing)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
            }
            .navigationTitle("Saved Drawings")
            .navigationBarItems(trailing: Button("Done") {
                // Close the modal
            })
        }
    }
}


