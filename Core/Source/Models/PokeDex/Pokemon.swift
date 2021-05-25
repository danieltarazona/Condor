//
//  Pokemon.swift
//  Core
//
//  Created by Daniel Tarazona on 5/21/21.
//

import Foundation
import CouchbaseLiteSwift
import CouchbaseLiteSwiftCoder

// MARK: - Pokemon
class Pokemon: Storable {
    required init() {}
    
    var id: Int?
    var abilities: [Ability]?
    var base_experience: Int?
    var game_indices: [GameIndex]?
    var height: Int?
    var moves: [Move]?
    var name: String?
    var order: Int?
    var species: Species?
    var sprites: Sprites?
    var stats: [Stat]?
    var types: [TypeElement]?
    var weight: Int?
    var url: String?
    var liked: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case abilities
        case base_experience = "base_experience"
        case game_indices = "game_indices"
        case height
        case moves
        case name
        case order
        case species
        case sprites
        case stats
        case types
        case weight
        case url
        case liked
    }

    init(abilities: [Ability]?, base_experience: Int?, game_indices: [GameIndex]?, height: Int?, id: Int, moves: [Move]?, name: String?, order: Int?, species: Species?, sprites: Sprites?, stats: [Stat]?, types: [TypeElement]?, weight: Int?, url: String?, liked: Bool?) {
        self.id = id
        self.document = MutableDocument(id: UUID().uuidString)
        self.abilities = abilities
        self.base_experience = base_experience
        self.game_indices = game_indices
        self.height = height
        self.moves = moves
        self.name = name
        self.order = order
        self.species = species
        self.sprites = sprites
        self.stats = stats
        self.types = types
        self.weight = weight
        self.url = url
        self.liked = liked
    }
    
    var official_artwork: String? {
        return sprites?.other?.official_artwork?.front_default
    }
    
    var document: MutableDocument! = MutableDocument(id: UUID().uuidString)
    
    var orderFormatted: String? {
        if let order = order {
            return String(order)
        }
        return nil
    }
    
    lazy var spritesFormatted: [String] = {
        var images = [String]()
        
        if let official_artwork = sprites?.other?.official_artwork?.front_default {
            images.append(official_artwork)
        }
        
        if let back_default = sprites?.back_default {
            images.append(back_default)
        }
        
        if let back_female = sprites?.back_female {
            images.append(back_female)
        }
        
        if let back_shiny = sprites?.back_shiny {
            images.append(back_shiny)
        }
        
        if let back_shiny_female = sprites?.back_shiny_female {
            images.append(back_shiny_female)
        }
        
        if let front_default = sprites?.front_default {
            images.append(front_default)
        }
        
        if let front_female = sprites?.front_female {
            images.append(front_female)
        }
        
        if let front_shiny = sprites?.front_shiny {
            images.append(front_shiny)
        }
        
        if let front_shiny_female = sprites?.front_shiny_female {
            images.append(front_shiny_female)
        }
        return images
    }()
}

// MARK: - Ability
class Ability: CBLCodable {
    var ability: Species?
    var is_hidden: Bool?
    var slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability = "ability"
        case is_hidden = "is_hidden"
        case slot = "slot"
    }

    init(ability: Species?, is_hidden: Bool?, slot: Int?) {
        self.ability = ability
        self.is_hidden = is_hidden
        self.slot = slot
    }
}

// MARK: - Species
class Species: CBLCodable {
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

// MARK: - GameIndex
class GameIndex: CBLCodable {
    var game_index: Int?
    var version: Species?

    enum CodingKeys: String, CodingKey {
        case game_index = "game_index"
        case version = "version"
    }

    init(game_index: Int?, version: Species?) {
        self.game_index = game_index
        self.version = version
    }
}

// MARK: - Move
class Move: Identifiable, CBLCodable {
    var move: Species?
    var version_group_details: [VersionGroupDetail]?

    enum CodingKeys: String, CodingKey {
        case move = "move"
        case version_group_details = "version_group_details"
    }

    init(move: Species?, version_group_details: [VersionGroupDetail]?) {
        self.move = move
        self.version_group_details = version_group_details
    }
}

// MARK: - VersionGroupDetail
class VersionGroupDetail: CBLCodable {
    var level_learned_at: Int?
    var move_learn_method: Species?
    var version_group: Species?

    enum CodingKeys: String, CodingKey {
        case level_learned_at = "level_learned_at"
        case move_learn_method = "move_learn_method"
        case version_group = "version_group"
    }

    init(level_learned_at: Int?, move_learn_method: Species?, version_group: Species?) {
        self.level_learned_at = level_learned_at
        self.move_learn_method = move_learn_method
        self.version_group = version_group
    }
}

// MARK: - Sprites
class Sprites: CBLCodable {
    var back_default: String?
    var back_female: String?
    var back_shiny: String?
    var back_shiny_female: String?
    var front_default: String?
    var front_female: String?
    var front_shiny: String?
    var front_shiny_female: String?
    var other: Other?

    enum CodingKeys: String, CodingKey {
        case back_default = "back_default"
        case back_female = "back_female"
        case back_shiny = "back_shiny"
        case back_shiny_female = "back_shiny_female"
        case front_default = "front_default"
        case front_female = "front_female"
        case front_shiny = "front_shiny"
        case front_shiny_female = "front_shiny_female"
        case other = "other"
    }

    init(back_default: String?, back_female: String?, back_shiny: String?, back_shiny_female: String?, front_default: String?, front_female: String?, front_shiny: String?, front_shiny_female: String?, other: Other?) {
        self.back_default = back_default
        self.back_female = back_female
        self.back_shiny = back_shiny
        self.back_shiny_female = back_shiny_female
        self.front_default = front_default
        self.front_female = front_female
        self.front_shiny = front_shiny
        self.front_shiny_female = front_shiny_female
        self.other = other
    }
}

// MARK: - Other
class Other: CBLCodable {
    var official_artwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case official_artwork = "official-artwork"
    }

    init(official_artwork: OfficialArtwork?) {
        self.official_artwork = official_artwork
    }
}

// MARK: - OfficialArtwork
class OfficialArtwork: Storable {
    required init() {}
    
    lazy var document: MutableDocument! = {
        return MutableDocument(id: front_default)
    }()
    
    var front_default: String?

    enum CodingKeys: String, CodingKey {
        case front_default = "front_default"
    }

    init(front_default: String?) {
        self.document = MutableDocument(id: front_default)
        self.front_default = front_default
    }
}

// MARK: - Stat
class Stat: CBLCodable {
    var base_stat: Int?
    var effort: Int?
    var stat: Species?

    enum CodingKeys: String, CodingKey {
        case base_stat = "base_stat"
        case effort = "effort"
        case stat = "stat"
    }

    init(base_stat: Int?, effort: Int?, stat: Species?) {
        self.base_stat = base_stat
        self.effort = effort
        self.stat = stat
    }
}

// MARK: - TypeElement
class TypeElement: Identifiable, CBLCodable {
    var slot: Int?
    var type: Species?
    
    enum CodingKeys: String, CodingKey {
        case slot = "slot"
        case type = "type"
    }

    init(slot: Int?, type: Species?) {
        self.slot = slot
        self.type = type
    }
}
