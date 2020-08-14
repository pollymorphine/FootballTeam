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

    
        override  func viewDidLoad() {
            super.viewDidLoad()
            
           // self.navigationItem.title = titleName
            tableView.tableFooterView = UIView()
            setupViews()
        }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //guard let devices = devices else { return [Device]().count }
           // return devices.count
            return 5
        }
        
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MainTableViewCell
                else { return UITableViewCell() }
            
//            if let device = devices?[indexPath.row] {
//                cell.setupCell(with: device)
//            }
            return cell
        }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        private func setupViews() {
//            costSum.text = String(sum!) + "₽"
//            userName.text = usersName
//            userAdress.text = usersAdress
//            userPhoneNumber.text = String(usersPhone!)
//            orderStatus.text = status
        }
    }
    

