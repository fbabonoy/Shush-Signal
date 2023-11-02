//
//  Wiggle .swift
//  Dog
//
//  Created by fernando babonoyaba on 9/19/23.
//

import SwiftUI

struct WigglingAnimationModifier: ViewModifier {
    @State private var isWiggling = false
    @Binding var isPressed: Bool

    func body(content: Content) -> some View {
        if isPressed {
            content
                .foregroundColor(.black)
                .rotationEffect(.degrees(isWiggling ? 10 : -10), anchor: .center)
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) {
                        isWiggling.toggle()
                    }
                }
        } else {
            content
                .foregroundColor(.green)
        }
        
    }
}
