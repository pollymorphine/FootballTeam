//
//  AppDelegate.swift
//  FootballTeam
//
//  Created by Polina on 10.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dataManager = CoreDataManager(modelName: Name.model)
        let storyboard = UIStoryboard(name: Name.main, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: Name.mainIdentifier) as? MainViewController
        vc?.dataManager = dataManager
        window = UIWindow()
        window?.rootViewController = UINavigationController.init(rootViewController: vc!)
        window?.makeKeyAndVisible()
        return true
    }
}

