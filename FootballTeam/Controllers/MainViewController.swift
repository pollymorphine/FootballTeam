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
    
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - Properties
    
    private var searchPredicate = NSCompoundPredicate()
    private var segmentedControl: UISegmentedControl!
    private var players = [Player]()
    var dataManager: CoreDataManager!
    var fetchedResultController: NSFetchedResultsController<Player>?
    
    
    // MARK: - Life cyrcle
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // запустить один раз, чтоб подгрузить пример
        //fillDataModel()
        mainTableView.tableFooterView = UIView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainTableView.reloadData()
       // dataManager.save()

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
    
    @IBAction private func addPlayerButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: Name.main, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Name.playerIdentifier) as! PlayerViewController
        vc.dataManager = dataManager
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func segmentedControlChanged(_ sender: Any?) {
        players.removeAll()
        fetchData(predicate: Predicate.empty)
        mainTableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func fetchData(predicate: NSCompoundPredicate? = nil) {
        var newPredicate = predicate
        
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            newPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [newPredicate ?? searchPredicate, Predicate.inPlay])
        case 2:
            newPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [newPredicate ?? searchPredicate, Predicate.onBench])
        default:
            break
        }
        
        fetchedResultController = dataManager.fetchDataWithController(for: Player.self,
                                                                      sectionNameKeyPath: Text.position,
                                                                      predicate: newPredicate)
        fetchedResultController?.delegate = self
        fetchedObjectsCheck(predicate: predicate)
    }
    
    private func fetchedObjectsCheck(predicate: NSCompoundPredicate? = nil) {
        guard let objects = fetchedResultController?.fetchedObjects else { return }
        
        if objects.count > 0 {
            mainTableView.isHidden = false
        } else {
            mainTableView.isHidden = true
        }
    }
    
    private func setupUI() {
        let headerView = UIView (frame: CGRect(x: 0,
                                               y: 0,
                                               width: mainTableView.frame.size.width,
                                               height: 50))
        
        let segment = UISegmentedControl(frame: CGRect(x: 10,
                                                       y: 10,
                                                       width: mainTableView.frame.size.width - 20,
                                                       height: 30))
        
        segment.insertSegment(withTitle: Text.all, at: 0, animated: true)
        segment.insertSegment(withTitle: Text.inPlay, at: 1, animated: true)
        segment.insertSegment(withTitle: Text.bench, at: 2, animated: true)
        segment.backgroundColor = Color.greenTheme
        segment.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        segment.selectedSegmentIndex = 0
        
        headerView.addSubview(segment)
        
        self.segmentedControl = segment
        self.mainTableView.tableHeaderView = headerView
        
        navigationController?.navigationBar.barTintColor = .white
    }
}

// MARK: - DataSourse & Delegate

extension MainViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultController?.sections else { return 0 }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = fetchedResultController?.sections else { return nil }
        return sections[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultController?.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Name.cellIdentifier, for: indexPath) as? MainTableViewCell
            else { return UITableViewCell() }
        
        guard let player = fetchedResultController?.object(at: indexPath) else { return cell }
        cell.setupCell(with: player)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let currentPlayer = self.fetchedResultController?.object(at: indexPath) else { return nil }
        
        let statusButton = currentPlayer.inPlay ? Text.inPlay : Text.bench

        let delete = UIContextualAction(style: .destructive, title: nil) { (action, view, success) in
            self.dataManager.delete(object: currentPlayer)
        }
        
        let edite = UIContextualAction(style: .normal, title: nil) { (action, view, success) in
            let storyboard = UIStoryboard(name: Name.main, bundle: nil)
            let playerViewController = storyboard.instantiateViewController(withIdentifier: Name.playerIdentifier) as! PlayerViewController
            playerViewController.player = currentPlayer
            self.navigationController?.pushViewController(playerViewController, animated: true)
        }
        
        let status = UIContextualAction(style: .normal, title: statusButton) { (action, view, success) in
            currentPlayer.inPlay = !currentPlayer.inPlay
            self.dataManager.save(context: self.dataManager.getContext())
       }
        
        delete.image = Image.thrash
        edite.image =  Image.edite
        edite.backgroundColor = Color.customGreen
        status.backgroundColor = .darkGray
        
        return UISwipeActionsConfiguration(actions: [delete, edite, status])
    }
}

// MARK: - Search Delegate

extension MainViewController: SearchDelegate {
    
    func viewController(_ viewController: SearchViewController, didPassedData predicate: NSCompoundPredicate) {
        Predicate.empty = predicate
        fetchData(predicate: predicate)
        mainTableView.reloadData()
    }
}

// MARK: - Fetched Results Controller Delegate

extension MainViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            mainTableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .delete:
            mainTableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                mainTableView.insertRows(at: [indexPath], with: .fade)
                fetchedObjectsCheck()
            }
            
        case .delete:
            if let indexPath = indexPath {
                mainTableView.deleteRows(at: [indexPath], with: .fade)
                fetchedObjectsCheck()
            }
            
        case .update:
            if let indexPath = indexPath {
                let cell = mainTableView.cellForRow(at: indexPath) as! MainTableViewCell
                let player = fetchedResultController?.object(at: indexPath as IndexPath)
                cell.setupCell(with: player!)
            }
            
        case .move:
            if let indexPath = indexPath {
                mainTableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                mainTableView.insertRows(at: [indexPath], with: .fade)
            }
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainTableView.endUpdates()
    }
}
