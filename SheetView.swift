//
//  profileSelection.swift
//  Final_Project
//
//  Created by Canon Helpman on 4/13/25.
//

import SwiftUI
import Foundation

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
//    @Binding var pickedColor: Color
    @Binding var player: Player
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .pink, .brown]
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                Text("Pick A Color")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(player.color)
                HStack{
                    ForEach(colors, id: \.self){color in
                        Button{
                            player.color = color
                        }label:{
                            Image(systemName: "paintpalette.fill").resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(color)
                        }
                    }
                }
                .padding()
                Button{
                    dismiss()
                }label:{
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(player.color)
                }
            }
            .padding()
        }
    }
}
