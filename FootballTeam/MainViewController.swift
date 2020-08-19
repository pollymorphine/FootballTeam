//
//  MainViewController.swift
//  FootballTeam
//
//  Created by Polina on 10.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit
import  CoreData
import  Foundation

class MainViewController: UITableViewController {
    
    var dataManager: CoreDataManager!
    
    private var players = [Player]()
    
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        // self.navigationItem.title = titleName
        // tableView.tableFooterView = UIView()
        setupViews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return players.count
    //return 10
    }
    
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MainTableViewCell
            else { return UITableViewCell() }
        
       cell.setupCell(with: players[indexPath.row])
        
        return cell
    }
    
    @IBOutlet weak var nav: UINavigationItem!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction private func addItemButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        
        vc.dataManager = dataManager
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    private func setupViews() {
   
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        self.dataManager?.delete(object: self.players[indexPath.row])
       players = self.dataManager!.fetchData(for: Player.self)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}


