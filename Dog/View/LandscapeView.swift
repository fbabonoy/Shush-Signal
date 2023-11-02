//
//  LandscapeView.swift
//  Dog
//
//  Created by fernando babonoyaba on 10/24/23.
//

import SwiftUI

struct LandscapeView: View {
    
    @State var volume: Float = 0.25
    @State var hertz: Double = 50.0
    @State var isPresented: Bool = false
    @State var isSelected = false
    
    
    var continuousButtonColor: Color {
        if isSelected {
            return Color.green
        }
        
        return .init(red: 0.1, green: 0.1, blue: 0.1)
    }

    var body: some View {
        GeometryReader { screen in
            
            HStack(alignment: .center){
//                Spacer()
                
                SoundButton(buttonAnimation: .constant(false), continuous: $isPresented, size: screen.size.height, volume: volume, hertz: hertz, unit: ToneV2())
                    .animation(.spring(), value: screen.size)
//                Spacer()
                
//                
//                Button {
//                    isSelected.toggle()
//                } label: {
//                    Text("Continuous")
//                }
//                .font(.title)
//                .padding(10)
//                .foregroundColor(isSelected ? .black : .white)
//                .background(continuousButtonColor)
//                .cornerRadius(50)
//                
//                Spacer()
//                
//                Slider(value: $hertz, in: 1...200)
//                    .tint(.green)
//                
//                Spacer()
//                
//                
//                Text("\(Int(hertz) * 100) Hz")
//                    .font(.title)
//                Spacer()
                
                
            }
        }
    }
    
    
}

#Preview {
    LandscapeView()
}
