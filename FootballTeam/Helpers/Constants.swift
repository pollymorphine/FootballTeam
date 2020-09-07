//
//  Constants.swift
//  FootballTeam
//
//  Created by Polina on 16.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import Foundation
import UIKit

enum Array {
    static let teams = ["Juventus", "Real Madrid", "Barcelona", "Chelsea", "Arsenal"]
    static let position = ["Midfielder", "Goalkeeper", "Defender", "Forward" ]
}

enum Text {
    static let done = "Done"
    static let cancel = "Cancel"
    static let chooseTeam = "Choose team"
    static let choosePosition = "Choose position"
    static let message = "\n\n\n\n\n\n\n\n\n"
    static let titlePlayerVC = "Add player"
    static let selectTeam = "Select team"
    static let selectPosition = "Select position"
    static let all = "All"
    static let inPlay = "in Play"
    static let bench = "Bench"
    static let position = "position"
}

enum Name {
    static let main = "Main"
    static let model = "FootballTeam"
    static let mainIdentifier = "MainViewController"
    static let playerIdentifier = "PlayerViewController"
    static let searchIdentifier = "SearchViewController"
    static let cellIdentifier = "Cell"
}

enum Predicate {
    static let playerName = "fullName CONTAINS[cd]"
    static let teamName = "team.name CONTAINS[cd]"
    static let position = "position CONTAINS[cd]"
    static let age = "age"
    static var empty = NSCompoundPredicate(andPredicateWithSubpredicates: [])
    static let inPlay = NSPredicate(format: "inPlay = true")
    static let onBench = NSPredicate(format: "inPlay = false")
}

enum Color {
    public static var greenTheme: UIColor {
        return UIColor(red: 0.882, green: 1.0, blue: 0.886, alpha: 0.6)
    }
    
    public static var customGreen: UIColor {
        return UIColor(red: 0.317, green: 0.724, blue: 0.206, alpha: 1)
    }
}
    
enum Image {
        public static var thrash: UIImage {
            return UIImage(systemName: "trash") ?? UIImage()
        }
        public static var edite: UIImage {
            return UIImage(systemName: "square.and.pencil") ?? UIImage()
        }
    }

