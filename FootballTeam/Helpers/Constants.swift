//
//  Constants.swift
//  FootballTeam
//
//  Created by Polina on 16.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import Foundation

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
}
