//
//  Generation.swift
//  Core
//
//  Created by Daniel Tarazona on 5/21/21.
//

import Foundation
import CouchbaseLiteSwift
import CouchbaseLiteSwiftCoder

// MARK: - Generation
class Generation: Codable {
    var id: Int?
    var main_region: MainRegion?
    var name: String?
    var pokemon_species: [PokemonSpecy]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main_region = "main_region"
        case name = "name"
        case pokemon_species = "pokemon_species"
    }

    init(id: Int?, main_region: MainRegion?, name: String?, pokemon_species: [PokemonSpecy]?) {
        self.id = id
        self.main_region = main_region
        self.name = name
        self.pokemon_species = pokemon_species
    }
}

// MARK: - MainRegion
class MainRegion: CBLCodable {
    var name: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }

    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

// MARK: - MainRegion
class PokemonSpecy: Storable {
    
    required init() {}
    
    lazy var document: MutableDocument! = {
        return MutableDocument(id: name)
    }()
    
    var name: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }

    init(name: String?, url: String?) {
        self.document = MutableDocument(id: name)
        self.name = name
        self.url = url
    }
}

