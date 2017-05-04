//
//  PokeCellCollectionViewCell.swift
//  PokeDex
//
//  Created by Ben on 5/4/17.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class PokeCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLabel.text = self.pokemon.name.capitalized
        thumbImage.image = UIImage(named: String(self.pokemon.pokedexID))
    }
    
}
