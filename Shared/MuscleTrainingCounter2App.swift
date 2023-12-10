//
//  MuscleTrainingCounter2App.swift
//  Shared
//
//  Created by 上別縄祐也 on 2022/03/09.
//

import SwiftUI
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        setup()
        return true
    }
}

@main
struct MuscleTrainingCounter2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init(){
        GADMobileAds.sharedInstance().start(completionHandler: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
//                     ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//                            switch status {
//                            case .authorized:
//                                print("OK")
//                            case .denied, .restricted, .notDetermined:
//                                print("だめでした。")
//                            @unknown default:
//                                fatalError()
//                            }
//                        })
//                     }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


