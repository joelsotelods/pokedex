//
//  Constants.swift
//  pokedex
//
//  Created by Joel Sotelo Llamas on 3/30/17.
//  Copyright © 2017 joel sotelo. All rights reserved.
//

import Foundation

let URL_BASE = "http://pokeapi.co/api/"
let URL_VERSION = "v1"
let URL_POKEMON = "/pokemon/"

let URL_FINAL = URL_BASE + URL_VERSION + URL_POKEMON


typealias DownloadComplete = () -> ()
