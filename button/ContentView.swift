//
//  ContentView.swift
//  button
//
//  Created by oiu on 07.10.2023.
//

import SwiftUI

struct PlayerButtonStyle: ButtonStyle {
    
    var duration: Double = 0.22
    var scale: Double = 0.86
    @State private var isPressed: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(0)
            .background {
                if isPressed {
                    Circle()
                        .foregroundColor(.black.opacity(0.1))
                        .frame(width: 100, height: 100)
                }
            }
            .scaleEffect(isPressed ? scale : 1)
            .animation(.linear(duration: duration), value: isPressed)
            .onChange(of: configuration.isPressed, perform: { newValue in
                guard newValue else { return }
                
                isPressed = newValue
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    isPressed = false
                }
            })
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
            HStack(spacing: 0) {
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
    }
    
    var icon: some View {
        Image(systemName: "play.fill")
            .resizable()
            .foregroundColor(.black)
    }
}

struct ContentView: View {
    var body: some View {
        HStack {
            VStack {
                PlayerButton()
                    .buttonStyle(PlayerButtonStyle(duration: 1, scale: 0))
                    .padding([.bottom], 100)
                
                Text("duration: 1 sec")
                Text("scale: 0")
            }
            VStack {
                PlayerButton()
                    .buttonStyle(PlayerButtonStyle())
                    .padding([.bottom], 100)
                
                Text("duration: default")
                Text("scale: default")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
