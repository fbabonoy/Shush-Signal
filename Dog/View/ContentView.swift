//
//  ContentView.swift
//  Dog
//
//  Created by fernando babonoyaba on 9/10/23.
//

import SwiftUI
import MediaPlayer


struct ContentView: View {
    @State var volume: Float = 0.25
    @State var hertz: Double = 50.0
    @State var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
            GeometryReader { screen in
                
                VStack{
                    HStack {
                        Spacer()
                        Button {
                            isPresented = true
                        } label: {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: screen.size.width * 0.1, height: screen.size.width * 0.1)
                                .tint(.white)
                        }
                        .sheet(isPresented: $isPresented, content: {
                            NavigationView {
                                Settings()
                                    .navigationBarItems(trailing: Button("Done") {
                                        isPresented = false // Dismiss the sheet
                                    })
                            }
                        })
                    }
                    
                    Spacer()
                    
                    SoundButton(size: screen.size, volume: volume, hertz: hertz)
                        .animation(.spring(), value: screen.size)
                    Spacer()
                    //                Divider()
                    
                    //                Slider(value: $volume)
                    //                    .padding(.bottom, 50)
                    
                    Slider(value: $hertz, in: 1...200)
                        .tint(.green)
                    
                    
                    Text("\(Int(hertz) * 100) Hz")
                        .font(.title)
                    Spacer()
                    
                    
                }
            }
            .padding()
            
        }
        .preferredColorScheme(.dark)
        //        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
