//
//  AppDelegate.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 30/06/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import UIKit
import AlamofireEasyLogger
import CoreData
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let alamofireLogger = FancyAppAlamofireLogger(
        logFunction: {data in
            print(data)
    }
    )
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #if targetEnvironment(simulator)
        application.setMinimumBackgroundFetchInterval(720)
        #else
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "id.kyald.DicodingGames.refresh",
            using: nil) { (task) in
                self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
        #endif
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Mendapatkan izin dari pengguna untuk local notifications")
            } else {
                print("Tidak mendapatkan izin dari pengguna untuk local notifications")
            }
        }

        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        HomeRemoteDataManager().compareNewReleasedGameData { (isNewRelease) in
            if isNewRelease {
                self.notificaiton()
            }
        }
    }
    
    func scheduleBackgroundFetch() {
        let fetchTask = BGAppRefreshTaskRequest(identifier: "id.kyald.DicodingGames.refresh")
        fetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        do {
          try BGTaskScheduler.shared.submit(fetchTask)
        } catch {
          print("Unable to submit task: \(error.localizedDescription)")
        }
    }

    func handleAppRefreshTask(task: BGAppRefreshTask) {
        task.expirationHandler = {
            HomeRemoteDataManager().compareNewReleasedGameData { (isNewRelease) in
                if isNewRelease {
                    self.notificaiton()
                }
            }
        }
    }
    
    private func notificaiton(){
        let fixedString = "Dicoding Games"
        let dynamicString = "New game has been released!"
        
        let content = UNMutableNotificationContent()
        content.title = fixedString
        content.body = dynamicString
        content.sound = .default
        content.userInfo = ["value": "Data dengan local notification"]
        
        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(1))
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
      
        let request = UNNotificationRequest(identifier: "message", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "Terjadi kesalahan dalam local notification")")
            }
        }
        
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
//        scheduleAppRefresh()
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Dicoding_Games")
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



extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UserInfo yang terkait dengan notifikasi == \(response.notification.request.content.userInfo)")
        
        completionHandler()
    }
}
