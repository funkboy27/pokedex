//
//  PokemonDetailVC.swift
//  PokeDex-Matt
//
//  Created by Matthew Wells on 2015-10-20.
//  Copyright © 2015 Matthew Wells. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
    }
}
