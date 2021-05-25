//
//  FeedInteractor.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import Foundation
import CouchbaseLiteSwiftCoder
import Alamofire

class FeedInteractor: ObservableObject {
    @Published var networkManager = NetworkManager()
    @Published var users: [User] = []
    @Published var photos: [ImageBlob] = []
    
    var url = "https://mock.koombea.io/mt/api/users/posts"
    let databaseManager = Couchbase(name: "Koombea")

    init() {
        getUsers()
    }
    
    func getUsers() {
        if networkManager.offline {
            let users = self.databaseManager.queryAll(type: User.self)
            if let users = users, users.count > 0 {
                self.users = users
            }
            return
        }
        
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let value):
                if let json = value {
                    let feed = try? newJSONDecoder().decode(Feed.self, from: json)
                    if let users = feed?.data {
                        
                        DispatchQueue.main.async {
                            self.users = users
                        }
                        
                        users.forEach { user in
                            if let _ = user.posts {
                                self.databaseManager.save(user)
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
