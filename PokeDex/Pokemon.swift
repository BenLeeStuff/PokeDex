//
//  Pokemon.swift
//  PokeDex
//
//  Created by Ben on 5/4/17.
//  Copyright © 2017 Ben. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLvl: String!
    
    private var _pokemonURL: String!
    
    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            return ""
        } else {
            return _nextEvolutionLvl
        }
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            return ""
        } else {
            return _nextEvolutionID
        }
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            return ""
        } else {
            return _nextEvolutionName
        }
    }

    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            return ""
        } else {
            return _nextEvolutionTxt
        }
    }
    
    var attack: String {
        if _attack == nil {
            return ""
        } else {
            return _attack
        }
    }
    
    var weight: String {
        if _weight == nil {
            return ""
        } else {
            return _weight
        }
    }
    
    var height: String {
        if _height == nil {
            return ""
        } else {
            return _height
        }
    }
    
    var defense: String {
        if _defense == nil {
            return ""
        } else {
            return _defense
        }
    }
    
    var type: String {
        if _type == nil {
            return ""
        } else {
            return _type
        }
    }
    
    var description: String {
        if _description == nil {
            return ""
        } else {
            return _description
        }
    }
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID!)/"
    }
    
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        // Alamofire get request
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = String(attack)
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = String(defense)
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    print(self._type)
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0  {
                    
                    if let url = descArr[0]["resource_uri"] {
                        let descUrl = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descUrl).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    print(newDescription)
                                    self._description = newDescription
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    if let nextEvolution = evolutions[0]["to"] as? String {
                        if nextEvolution.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvolution
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoID = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionID = nextEvoID
                                
                                if let lvlExist = evolutions[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolutionLvl = String(lvl)
                                    }
                                    else {
                                        self._nextEvolutionLvl = ""
                                    }
                                }
                            }
                        }
                        print(self.nextEvolutionLvl)
                        print(self.nextEvolutionName)
                        print(self.nextEvolutionID)
                    }
                }
            }
             completed()
            
            
        }
    }
}
