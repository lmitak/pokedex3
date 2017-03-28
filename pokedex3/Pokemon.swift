//
//  Pokemon.swift
//  pokedex3
//
//  Created by Luka Mitak on 27/03/17.
//  Copyright © 2017 lmitak. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _height, _defense, _weight, _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            print(response.result.value)
            
            if let mainDict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = mainDict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = mainDict["height"] as? String {
                    self._height = height
                }
                
                if let attack = mainDict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = mainDict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = mainDict["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for i in 1..<types.count {
                            if let name = types[i]["name"] as? String {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descArr = mainDict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        Alamofire.request("\(URL_BASE)\(url)").responseJSON(completionHandler: { response in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let desc = descDict["description"] as? String {
                                    let fixedDesc = desc.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = fixedDesc
                                }
                            }
                            completed()
                        })
                    }
                    
                } else {
                    self._description = ""
                }
                if let evolutions = mainDict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    print("Evolution is here!")
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvo
                        }
                        
                    }
                    if let uri = evolutions[0]["resource_uri"] as? String {
                        let newStr = uri.replacingOccurrences(of: URL_POKEMON, with: "")
                        let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                        self._nextEvolutionId = nextEvoId
                    }
                    if let lvlExist = evolutions[0]["level"] {
                        if let lvl = lvlExist as? Int {
                            self._nextEvolutionLevel = "\(lvl)"
                        }
                    } else {
                        self._nextEvolutionLevel = ""
                    }
                }
            }
            completed()
        }
    }
    
}
