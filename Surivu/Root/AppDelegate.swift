//
//  AppDelegate.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 18/09/25.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        dependencies = Dependencies()
        return true
    }
}
