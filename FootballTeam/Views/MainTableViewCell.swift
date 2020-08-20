//
//  MainTableViewCell.swift
//  FootballTeam
//
//  Created by Polina on 10.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var age: UILabel!
    
    func setupCell(with player: Player) {
        fullName.text = player.fullName
        number.text = String(player.number)
        team.text = player.club?.name
        nationality.text = player.nationality
        position.text = player.position
        age.text = String(player.age)
        
        if let image = player.image as? UIImage {
            photo.image = image
        }
    }
}