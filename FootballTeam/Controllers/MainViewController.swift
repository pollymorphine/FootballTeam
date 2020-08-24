//
//  MainViewController.swift
//  FootballTeam
//
//  Created by Polina on 10.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit
import  CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
   
    private var players = [Player]()
    var dataManager: CoreDataManager!

    override  func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       // fillDataModel() 
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
        tableView.reloadData()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: Name.main, bundle: nil)
        let searchViewController = storyboard.instantiateViewController(withIdentifier: Name.searchIdentifier) as! SearchViewController
        searchViewController.modalTransitionStyle = .crossDissolve
        searchViewController.modalPresentationStyle = .overCurrentContext
        searchViewController.delegate = self
        present(searchViewController, animated: false, completion: nil)
    }
    
    
    @IBAction private func addItemButtonPressed(_ sender: UIBarButtonItem) {
          let storyboard = UIStoryboard(name: Name.main, bundle: nil)
          let vc = storyboard.instantiateViewController(withIdentifier: Name.playerIdentifier) as! PlayerViewController
          vc.dataManager = dataManager
          navigationController?.pushViewController(vc, animated: true)
      }
    
    private func fetchData(predicate: NSCompoundPredicate? = nil) {
         players = dataManager.fetchData(for: Player.self, predicate: predicate)
         
         if !players.isEmpty {
             tableView.isHidden = false
         } else {
             tableView.isHidden = true
         }
         tableView.reloadData()
     }
    
    private func setupUI() {
        let headerView = UIView (frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width
                   , height: 70))
               let segment = UISegmentedControl(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width - 40, height: 30))
               segment.insertSegment(withTitle: "All", at: 0, animated: true)
               segment.insertSegment(withTitle: "In Play", at: 1, animated: true)
               segment.insertSegment(withTitle: "Bench", at: 2, animated: true)
        headerView.addSubview(segment)
        segment.selectedSegmentIndex = 0

        self.tableView.tableHeaderView = headerView
        
        navigationController?.navigationBar.barTintColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Name.cellIdentifier, for: indexPath) as? MainTableViewCell
            else { return UITableViewCell() }
        cell.setupCell(with: players[indexPath.row])
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.dataManager?.delete(object: self.players[indexPath.row])
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            fetchData()
        }
    }
}

extension MainViewController: SearchDelegate {
    func viewController(_ viewController: SearchViewController, didPassedData predicate: NSCompoundPredicate) {
        
    }
    
    
}



