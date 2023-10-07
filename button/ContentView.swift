//
//  ContentView.swift
//  button
//
//  Created by oiu on 07.10.2023.
//

import SwiftUI

struct PlayerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(0)
            .background {
                if configuration.isPressed {
                    Circle()
                        .foregroundColor(.black.opacity(0.1))
                        .frame(width: 100, height: 100)
                }
            }
    }
}

struct PlayerButton: View {
    
    enum Constants {
        static let size: CGFloat = 25
    }
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        Button {
            isAnimating = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                isAnimating = true
            }
        } label: {
            HStack(spacing: -2) {
                icon.frame(
                    width: isAnimating ? Constants.size : 0,
                    height: isAnimating ? Constants.size : 0
                )
                
                icon.frame(width: Constants.size, height: Constants.size)
                
                icon.frame(
                    width: isAnimating ? 0 : Constants.size,
                    height: isAnimating ? 0 : Constants.size
                )
            }
            .animation(
                isAnimating
                ? .interpolatingSpring(mass: 1.5, stiffness: 100, damping: 17, initialVelocity: 0)
                : .linear(duration: 0),
                value: isAnimating
            )
        }
        .buttonStyle(PlayerButtonStyle())
    }
    
    var icon: some View {
        Image(systemName: "play.fill")
            .resizable()
            .foregroundColor(.black)
    }
}

struct ContentView: View {
    var body: some View {
        PlayerButton()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
