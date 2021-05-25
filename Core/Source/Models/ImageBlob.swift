//
//  ImageBlob.swift
//  Core
//
//  Created by Daniel Tarazona on 5/21/21.
//

import Foundation
import CouchbaseLiteSwift
import CouchbaseLiteSwiftCoder

class ImageBlob: Storable {
    required init() {}
    
    lazy var document: MutableDocument! = {
        return MutableDocument(id: name)
    }()

    var name: String?
    var blob: Blob?
    
    init(name: String?, blob: Blob?) {
        self.document = MutableDocument(id: name)
        self.name = name
        self.blob = blob
    }
}
