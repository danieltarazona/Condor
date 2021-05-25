//
//  ImageInteractor.swift
//  Core
//
//  Created by Daniel Tarazona on 5/20/21.
//
import Foundation
import UIKit
import Combine

class ImageInteractor: ObservableObject {
    @Published var uiImage: UIImage = UIImage()
    
    let database = Couchbase(name: "Images")
    let requestManager = RequestManager()
    
    init(name: String) {
        getImage(name: name)
    }
    
    func getImage(name: String) {
        if name != nil { } else { return }
        guard !name.isEmpty else { return }
        
        if let data = database.getBlobData(name: name) {
            DispatchQueue.main.async {
                self.uiImage = data.toUIImage
            }
            return
        }
        
        guard name.isURL else {
            return
        }
        
        requestManager.getImage(name) { data in
            if let data = data {
                DispatchQueue.main.async {
                    self.uiImage = data.toUIImage
                }
                
                let blob = self.database.createImageBlob(data: data)
                let imageBlob = ImageBlob(name: name, blob: blob)
                self.database.save(imageBlob)
                return
            }
        }
    }
}



