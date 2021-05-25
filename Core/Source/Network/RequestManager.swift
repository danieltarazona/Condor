//
//  RequestManager.swift
//  Core
//
//  Created by Daniel Tarazona on 5/20/21.
//

import Foundation

class RequestManager {
    private let session = URLSession.shared
    
    var url = "https://pokeapi.co/api/v2/"
    
    func get(generation: Int, totalGeneration: Int, completion: (@escaping (Generation?) -> Void )) {
        guard isValidGeneration(actualGeneration: generation, totalGeneration: totalGeneration) else {
            print("Invalid Generation");
            return
        }
        
        let url = self.url + "generation/" + String(generation)
        let request = URL(string: url)
        
        if let request = request {
            session.dataTask(with: request, type: Generation.self) { generation, response, error in
                 if let generation = generation {
                   completion(generation)
                 }
            }.resume()
        }
    }
    
    func get(name: String, completion: (@escaping (Pokemon?) -> Void )) {
        if !name.isEmpty {
            let url = self.url + "pokemon/" + String(name)
            if let request = URL(string: url) {
                session.dataTask(with: request, type: Pokemon.self) { pokemon, response, error in
                    let response = response as? HTTPURLResponse
                    if error == nil {
                        if let pokemon = pokemon, response?.statusCode == 200 {
                            DispatchQueue.main.async {
                                completion(pokemon)
                            }
                        }
                    } else {
                        print(error?.localizedDescription ?? "")
                    }
                }.resume()
            }
        }
    }
    
    func getImage(_ path: String, completion: (@escaping (Data?) -> Void )) {
        if let url = NSURL(string: path) {
            session.dataTask(with: url as URL) { (data, response, error) in
                let response = response as? HTTPURLResponse
                if error == nil {
                    if let data = data, let response = response, response.statusCode == 200 {
                        DispatchQueue.main.async {
                            completion(data)
                        }
                    }
                } else {
                    print(error?.localizedDescription ?? "")
                }
            }.resume()
        }
    }
    
    func isValidGeneration(actualGeneration: Int, totalGeneration: Int) -> Bool {
        if actualGeneration > 0 && actualGeneration < totalGeneration + 1 {
            return true
        }
        return false
    }
}
