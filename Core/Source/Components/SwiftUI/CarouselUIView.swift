//
//  CarouselUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import SwiftUI

struct CarouselUIView: View {
    var images = [String]()
    
    var height: CGFloat = 128
    var spacing: CGFloat = 8
    
    var cornerRadius: CGFloat = 8
    var shadowRadius: CGFloat = 4
    var shadowOpacity: Double = 0.3

    var body: some View {
        images.count > 0 && images != nil ? ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(0..<images.count) { index in
                        ImageUIView(
                            name: images[index],
                            cornerRadius: cornerRadius,
                            shadowRadius: shadowRadius,
                            shadowOpacity: shadowOpacity
                    )}
                }
                .frame(maxWidth: .infinity, maxHeight: height)
            }
            } : nil
    }
}

#if DEBUG
struct CarouselUIView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselUIView()
    }
}
#endif
