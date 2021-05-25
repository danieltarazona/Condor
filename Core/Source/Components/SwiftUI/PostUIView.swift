//
//  PostUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import SwiftUI

struct PostUIView: View {
    var images: [String] = []
    var date: String = ""
    
    var body: some View {
        if images.count > 0 {
            VStack {
                !date.isEmpty ? Text(date ).font(.custom("Roboto-Regular", size: 11)) : nil
                switch images.count {
                case let x where x == 2:
                    HStack {
                        ImageUIView(name: images[0])
                        ImageUIView(name: images[1])
                    }
                case let x where x == 3:
                    ImageUIView(name: images[0] )
                    HStack {
                        ImageUIView(name: images[1])
                        ImageUIView(name: images[2])
                    }
                case let x where x >= 4:
                    ImageUIView(name: images[0] )
                    HStack {
                        ImageUIView(name: images[1])
                        ImageUIView(name: images[2])
                    }
                    
                    if let images = images {
                        let totalPics = Array(images.dropFirst(3))
                        CarouselUIView(images: totalPics)
                    }
                    
                default:
                    ImageUIView(name: images[0])
                }
            }
        }
    }
}

#if DEBUG
struct PostUIView_Previews: PreviewProvider {
    static var previews: some View {
        PostUIView()
    }
}
#endif
