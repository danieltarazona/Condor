//
//  ImageUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import SwiftUI
import CouchbaseLiteSwift

struct ImageUIView: View {
    @ObservedObject var interactor: ImageInteractor
    @State private var showModal = false
    @State var uiImage: UIImage = UIImage()
    
    @State var name: String
    
    var height: CGFloat = 256
    var width: CGFloat = 256

    var cornerRadius: CGFloat = 0
    var shadowRadius: CGFloat = 0
    var shadowOpacity: Double = 0.3
    
    var action: () -> Void = {}
    
    init(
        name: String,
        height: CGFloat = 256,
        width: CGFloat = 256,
        cornerRadius: CGFloat = 0,
        shadowRadius: CGFloat = 0,
        shadowOpacity: Double = 0.3
    ) {
        self.name = name
        self.uiImage = UIImage()
        self.height = height
        self.width = width
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.interactor = ImageInteractor(name: name)
    }
    
    var body: some View {
        Image(uiImage: interactor.uiImage)
            .resizable()
            .fullScreenCover(isPresented: $showModal) {
                ModalImageUIView(uiImage: interactor.uiImage) {
                    showModal = false
                }
            }
            .scaledToFit()
            .background(Color.white)
            .cornerRadius(cornerRadius)
            .shadow(
                color: Color.black.opacity(shadowOpacity),
                radius: shadowRadius
            )
            .onTapGesture {
                showModal = true
                action()
            }
            .onReceive(interactor.$uiImage, perform: { uiImage in
                self.uiImage = uiImage
            })
            .onAppear(perform: {
                interactor.getImage(name: name)
            })
    }
}

#if DEBUG
struct ImageUIView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUIView(name: "")
    }
}
#endif
