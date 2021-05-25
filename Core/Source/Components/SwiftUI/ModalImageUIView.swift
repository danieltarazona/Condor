//
//  OverlayUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import SwiftUI

struct ModalImageUIView: View {
    @State var uiImage: UIImage
    @State private var position = CGPoint(x: 160, y: 274)
    var initialPosition = CGPoint(x: 160, y: 274)
    
    var dismiss: () -> Void = {}
    
    var body: some View {
        ZStack {
            VStack { }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 8, opaque: true)
                .opacity(0.8)
            
            Image(uiImage: uiImage)
                .antialiased(true)
                .resizable()
                .scaledToFit()
                .background(Color.white)
                .position(position)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            if value.location.y > initialPosition.y && abs(value.location.y - initialPosition.y) < 160 {
                                self.position.y = value.location.y
                            }
                        }).onEnded({ value in
                            dismiss()
                            self.position = initialPosition
                        })
                )
                
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ModalImageUIView_Previews: PreviewProvider {
    static var previews: some View {
        ModalImageUIView(uiImage: UIImage())
    }
}
#endif
