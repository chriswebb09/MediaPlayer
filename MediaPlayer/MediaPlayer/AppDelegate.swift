//
//  AppDelegate.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoordinator: MainCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupUI()
        let mpMusic = MPUserMediaPlayer()
        mpMusic.getPlaylists()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.mainCoordinator = MainCoordinator(window: window!)
        mainCoordinator.start()
        return true
    }
    
    func setupUI() {
        let placeholderAttributes: [String : AnyObject] = [NSFontAttributeName: UIFont.systemFont(ofSize: UIFont.systemFontSize)]
        let attributedPlaceholder: NSAttributedString = NSAttributedString(string: "Search", attributes: placeholderAttributes)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = attributedPlaceholder
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0)
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont(name:"Avenir", size:22),
            NSForegroundColorAttributeName: UIColor.darkGray
        ]
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Implement save
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Implement save
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MediaPlayer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

