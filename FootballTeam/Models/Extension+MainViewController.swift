//
//  Extension+MainViewController.swift
//  FootballTeam
//
//  Created by Polina on 23.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit

extension MainViewController {
    
    func fillDataModel() {
        
        let context = dataManager.getContext()
        
        let team1 = dataManager.createObject(from: Club.self)
        team1.name = Array.teams[3]
        
        let player1 = dataManager.createObject(from: Player.self)
        player1.age = 38
        player1.fullName = "Wilfredo Caballero"
        player1.image = UIImage(named: "Wilfredo Caballero")
        player1.nationality = "Argentinian"
        player1.number = 12
        player1.position = Array.position[1]
        player1.club = team1
        player1.inPlay = true
        
        let team2 = dataManager.createObject(from: Club.self)
        team2.name = Array.teams[0]
        
        let player2 = dataManager.createObject(from: Player.self)
        player2.age = 35
        player2.fullName = "Cristiano Ronaldo"
        player2.image = UIImage(named: "Cristiano Ronaldo")
        player2.nationality = "Portuguese"
        player2.number = 7
        player2.position = Array.position[3]
        player2.club = team2
        player2.inPlay = false
        
        let team3 = dataManager.createObject(from: Club.self)
        team3.name = Array.teams[2]
        
        let player3 = dataManager.createObject(from: Player.self)
        player3.age = 33
        player3.fullName = "Arturo Vidal"
        player3.image = UIImage(named: "Arturo Vidal")
        player3.nationality = "Chilean"
        player3.number = 22
        player3.position = Array.position[0]
        player3.club = team3
        player3.inPlay = true
        
        let team4 = dataManager.createObject(from: Club.self)
        team4.name = Array.teams[1]
        
        let player4 = dataManager.createObject(from: Player.self)
        player4.age = 28
        player4.fullName = "Dani Carvajal"
        player4.image = UIImage(named: "Dani Carvajal")
        player4.nationality = "Hispanic"
        player4.number = 2
        player4.position = Array.position[2]
        player4.club = team4
        player4.inPlay = false
        
        let player5 = dataManager.createObject(from: Player.self)
        player5.age = 25
        player5.fullName = "Ferland Mendy"
        player5.image = UIImage(named: "Ferland Mendy")
        player5.nationality = "Frenchman"
        player5.number = 23
        player5.position = Array.position[2]
        player5.club = team4
        player5.inPlay = false
        
        let team6 = dataManager.createObject(from: Club.self)
        team6.name = Array.teams[4]
        
        let player6 = dataManager.createObject(from: Player.self)
        player6.age = 25
        player6.fullName = "Matt Macey"
        player6.image = UIImage(named: "Matt Macey")
        player6.nationality = "Britisher"
        player6.number = 21
        player6.position = Array.position[1]
        player6.club = team6
        player6.inPlay = true
        
      
        
        let player7 = dataManager.createObject(from: Player.self)
        player7.age = 26
        player7.fullName = "Paulo Dybala"
        player7.image = UIImage(named: "Paulo Dybala")
        player7.nationality = "Argentinian"
        player7.number = 10
        player7.position = Array.position[3]
        player7.club = team2
        player7.inPlay = true
        
        dataManager.save(context: context)
        
        
    }
    
}
