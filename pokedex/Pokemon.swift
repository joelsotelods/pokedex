//
//  Pokemon.swift
//  pokedex
//
//  Created by Joel Sotelo Llamas on 3/22/17.
//  Copyright © 2017 joel sotelo. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String
    private var _pokedexId: Int
    
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    private var _pokemonURL: String!
    
    
    // Get-ters
    
    var name: String {

        return _name
    }
    
    var pokedexId: Int {

        return _pokedexId
    }
    
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
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
    
    // Init
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_VERSION)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    // Alamofire requests for the detail
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON(completionHandler:  { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height =  dict["height"] as? String {
                    self._height = height
                }
                
                if let attack =  dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let type = types[0]["name"] {
                        self._type = type.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }
                else {
                    self._type = ""
                }
                
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0  {
                    
       
                    if let descriptionURL = descriptions[0]["resource_uri"] {
                        
                        Alamofire.request(URL_BASE + descriptionURL).responseJSON(completionHandler: { (response) in
                            
                            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let descriptiond = dict["description"] as? String {
                                    
                                    self._description = descriptiond
                                    print(descriptiond)
                                }
                            }
                            
                            completed()
                        })
                    }
                    else {
                        self._description = ""
                    }
                }
                
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvol = evolutions[0]["to"] as? String {
                        
                        if nextEvol.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvol.capitalized
                            
                            
                            if let nextEvolId = evolutions[0]["resource_uri"] as? String {
                                
                                /* //One way
                                 let index = nextEvolId.index(nextEvolId.startIndex, offsetBy: 16)
                                 let nextevolidnew = nextEvolId.substring(from: index)
                                 let token = nextevolidnew.components(separatedBy: "/")
                                 
                                 self._nextEvolutionId = token[0]*/
                                
                                let newStr = nextEvolId.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolId2 = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvolId2

                            }
                            
                            if let nextEvolLvl = evolutions[0]["level"] as? Int {
                                
                                self._nextEvolutionLevel = "\(nextEvolLvl)"
                            }
                            else {
                                self._nextEvolutionLevel = ""
                            }
                        }
                    }
                }
                else {
                    self._nextEvolutionName = ""
                    self._nextEvolutionLevel = ""
                    self._nextEvolutionId = ""
                    
                }
                

            }
            completed()
        })
    }
    
 
    
}
