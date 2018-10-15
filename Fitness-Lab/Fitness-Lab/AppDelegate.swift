//
//  AppDelegate.swift
//  Fitness-Lab
//
//  Created by 張書涵 on 2018/9/19.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
import IQKeyboardManagerSwift
import Firebase
import Fabric
import Crashlytics

//swiftlint:disable identifier_name
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let trackId = "UA-127437353-1"

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        //realm測試
        let summary = SummaryModel()
        summary.durationLbl = 600
        summary.scoreTitleLbl = "困難"
        summary.workoutDate = Date().timeIntervalSince1970
        summary.videoImg = "Abs3"
        summary.videoTitle = "連續22天的腹肌訓練計畫"

        do {
            let realm = try Realm()
            try realm.write {
               //  realm.add(summary)
            }
        } catch {
            print("Error initalisting new realm, \(error)")
        }

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in

        }
        
        IQKeyboardManager.shared.enable = true
        
        //Google analytics
        
        FirebaseApp.configure()
        
        guard let gai = GAI.sharedInstance() else {
            assert(false, "Google Analytics not configured correctly")
            return false
        }
        gai.tracker(withTrackingId: AppDelegate.trackId)
    
        gai.trackUncaughtExceptions = true
        
        //Google analytics
        Fabric.with([Crashlytics.self])
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}
