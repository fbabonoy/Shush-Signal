//
//  ContentView.swift
//  Dog
//
//  Created by fernando babonoyaba on 9/10/23.
//

import SwiftUI
import MediaPlayer


struct ContentView: View {
    
    @ObservedObject var soundController: SoundController = SoundController()
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        ZStack {
            Color.black
            if orientation.isPortrait {
                PortraitView(soundController: soundController)
            } else {
                if UIDevice.current.orientation.isLandscape {
                    LandscapeView(soundController: soundController)
                    
                } else {
                    PortraitView(soundController: soundController)
                    
                }
                
            }
            
        }
        .preferredColorScheme(.dark)
        .padding(.horizontal)
        .onRotate { newOrientation in
            soundController.resetOnRotation()
            orientation = newOrientation
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                let badOrientationCheck = UIDevice.current.orientation
                if !badOrientationCheck.isFlat && badOrientationCheck != .portraitUpsideDown {
                    action(UIDevice.current.orientation)
                }
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
