//
//  postTestApp.swift
//  postTest
//
//  Created by 呂沄 on 2023/3/6.
//

import SwiftUI

@main
struct postTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            login4()

        }
    }
    class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            // 请求推送通知权限
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if granted {
                    print("用户已同意推送通知")
                } else {
                    print("用户未同意推送通知")
                }
            }
            
            // 设置推送通知的代理
            UNUserNotificationCenter.current().delegate = self
            
            return true
        }
        
        // 在这里处理接收到的推送通知
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
                // 在這裡處理推播通知的點擊事件，顯示相應的視圖
                
                if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                    // 使用者點擊了通知，顯示你想要的視圖
                }
                
                completionHandler()
            }
    }
}
