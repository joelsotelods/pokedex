//
//  ViewController.swift
//  pokedex
//
//  Created by Joel Sotelo Llamas on 3/22/17.
//  Copyright © 2017 joel sotelo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let charmander = Pokemon(name: "Charmander", pokedexId: 4)
        
        print(charmander.name)
        
    }



}

