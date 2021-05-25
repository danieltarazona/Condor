//
//  Post.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import Foundation
import CouchbaseLiteSwift
import CouchbaseLiteSwiftCoder

// MARK: - Feed
class Feed: Codable {
    var data: [User]?

    init(data: [User]?) {
        self.data = data
    }
}

// MARK: - User
class User: Storable {
    required init() {}

    var uid: String?
    var name: String?
    var email: String?
    var profile_pic: String?
    var posts: [Post]?
    
    lazy var document: MutableDocument! = {
        return MutableDocument(id: uid)
    }()

    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case name = "name"
        case email = "email"
        case profile_pic = "profile_pic"
        case posts = "posts"
    }

    init(uid: String?, name: String?, email: String?, profile_pic: String?, posts: [Post]?) {
        self.document = MutableDocument(id: uid)
        self.uid = uid
        self.name = name
        self.email = email
        self.profile_pic = profile_pic
        self.posts = posts
    }
}

// MARK: - Post
class Post: Identifiable, CBLCodable {
    var id: Int?
    var date: String?
    var pics: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case pics = "pics"
    }

    init(id: Int?, date: String?, pics: [String]?) {
        self.id = id
        self.date = date
        self.pics = pics
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        
        guard let dateString = date else { return "" }
        
        formatter.dateFormat = "dd MMM"
        let date = formatter.date(from: dateString) ?? Date()
        
        formatter.dateFormat = "dd"
        let day = Int(formatter.string(from: date)) ?? 0
    
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: date)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        let ordinal = numberFormatter.string(from: NSNumber(value: day)) ?? ""
            
        return "\(ordinal) \(month)"
    }
}




