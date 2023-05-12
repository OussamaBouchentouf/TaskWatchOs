//
//  Home.swift
//  TaskWatch Watch App
//
//  Created by Robotics on 11/5/2023.
//

import SwiftUI

struct Home: View {
    var body: some View {
        // Geometry Reader for getting frame...
        GeometryReader { reader in
            let rect = reader.frame(in: .global)
            
            VStack(spacing: 15) {
                HStack(spacing: 25) {
                    // Buttons
                    NavigationLink(destination: AddItem()) {
                        NavButton(image: "plus", title: "Memo", rect: rect, color: .pink)
                    }
                    .buttonStyle(PlainButtonStyle())
                        
                    NavigationLink(destination: DeleteMemo()) {
                        NavButton(image: "trash", title: "Delete", rect: rect, color: .red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(width: rect.width, alignment: .center)
                
                HStack(spacing: 25) {
                    // Buttons
                    NavigationLink(destination: ViewMemo()) {
                        NavButton(image: "doc.plaintext", title: "View", rect: rect, color: Color.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
        
                    NavButton(image: "star", title: "Raiting", rect: rect, color: Color.orange)
                }
                .frame(width: rect.width, alignment: .center)
            }
        }
    }
}

struct NavButton: View {
    var image: String
    var title: String
    var rect: CGRect
    var color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: image)
                .font(.title2)
                .frame(width: rect.width / 3, height: rect.height / 3, alignment: .center)
                .background(color)
                .clipShape(Circle())
            
            Text(title)
                .font(.system(size: 10))
                .foregroundColor(.white)
        }
    }
}
