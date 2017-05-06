//
//  PokeCellCollectionViewCell.swift
//  PokeDex
//
//  Created by Ben on 5/4/17.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    //Configure cell here.
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name.capitalized
        thumbImage.image = UIImage(named: String(self.pokemon.pokedexID))

    }
    
    // Gives each cell rounded corners.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
}
