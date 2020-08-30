//
//  MainViewController.swift
//  FootballTeam
//
//  Created by Polina on 10.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit
import  CoreData

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private var selectedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [])
    private var segmentedControl: UISegmentedControl!
    private var players = [Player]()
    
    var dataManager: CoreDataManager!
    
    // MARK: - Life cyrcle
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //fillDataModel()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
        tableView.reloadData()
    }
    
    // MARK: - Methods
    
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
    
    @objc func segmentedControlChanged(_ sender: Any?) {
        fetchData(predicate: selectedPredicate)
        self.tableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func fetchData(predicate: NSCompoundPredicate? = nil) {
        let sortedPlayers = dataManager.fetchData(for: Player.self, predicate: predicate)
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            players = sortedPlayers
        case 1:
            players = sortedPlayers.filter({$0.inPlay})
        case 2:
            players = sortedPlayers.filter({!$0.inPlay})
        default:
            break
        }
        
        if !players.isEmpty {
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
        }
    }
    
    private func setupUI() {
        let headerView = UIView (frame: CGRect(x: 0,
                                               y: 0,
                                               width: tableView.frame.size.width,
                                               height: 70))
        
        let segment = UISegmentedControl(frame: CGRect(x: 20,
                                                       y: 20,
                                                       width: tableView.frame.size.width - 40,
                                                       height: 30))
        
        segment.insertSegment(withTitle: Text.all, at: 0, animated: true)
        segment.insertSegment(withTitle: Text.inPlay, at: 1, animated: true)
        segment.insertSegment(withTitle: Text.bench, at: 2, animated: true)
        segment.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        segment.selectedSegmentIndex = 0
        
        headerView.addSubview(segment)
        
        self.segmentedControl = segment
        self.tableView.tableHeaderView = headerView
        
        navigationController?.navigationBar.barTintColor = .white
    }
}

// MARK: - DataSourse & Delegate

extension MainViewController:  UITableViewDelegate, UITableViewDataSource {
    
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
        fetchData(predicate: predicate)
        tableView.reloadData()
    }
}



