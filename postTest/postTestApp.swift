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
//    @Binding var showSleepView = false
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
//        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//                // 在這裡處理推播通知的點擊事件，顯示相應的視圖
//                if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
//                    // 使用者點擊了通知，顯示你想要的視圖
//                    let sleepView = Sleep()
//                            let hostingController = UIHostingController(rootView: sleepView)
//
//                            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
//                                window.rootViewController?.present(hostingController, animated: true, completion: nil)
//                            }
//                }
//                completionHandler()
//            }
        
        
        
//        // 在这里处理接收到的推送通知
//        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//                // 在這裡處理推播通知的點擊事件，顯示相應的視圖
//                if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
//                    // 使用者點擊了通知，顯示你想要的視圖
//                    let sleepView = Sleep()
//                            let hostingController = UIHostingController(rootView: sleepView)
//
////                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
////                       let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
////                        window.rootViewController?.present(hostingController, animated: true, completion: nil)
////                        window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
////                    }
//                            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
//                                window.rootViewController?.present(hostingController, animated: true, completion: nil)
//                            }
//                }
//                completionHandler()
//            }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
               let notification = response.notification
               let notificationTitle = notification.request.content.title
               
               // 根据通知的标题跳转到不同的 SwiftUI 视图
            if notificationTitle == "該睡覺了！！" {
                print("該睡覺了！！")
                let view = Sleep()
                // 在这里进行导航或跳转到 ViewA 视图
                let hostingController = UIHostingController(rootView: view)
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    window.rootViewController?.present(hostingController, animated: true, completion: nil)
                }

            } else if notificationTitle == "該起床了！！" {
                print("該起床了！！")
                let view = wakeUp()
                // 在这里进行导航或跳转到 ViewA 视图
                let hostingController = UIHostingController(rootView: view)
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    window.rootViewController?.present(hostingController, animated: true, completion: nil)
                }

            }
            else {
                print("null")
            }
               completionHandler()
           }
       

        
        
//        // 接收到遠端推播通知時的處理
//            func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//                if let aps = userInfo["aps"] as? [String: Any] {
//                    if let alert = aps["alert"] as? String {
//                        // 判斷推播通知的內容
//                        if alert == "我醒來了" {
//                            showWakeUpView()
//                        }
//                    }
//                }
//            }
//
//            // 顯示醒來視圖
//            func showWakeUpView() {
//                guard let window = UIApplication.shared.windows.first,
//                      let rootViewController = window.rootViewController else {
//                    return
//                }
//
//                let wakeUpViewController = UIViewController()
//                wakeUpViewController.view.backgroundColor = UIColor.white
//
//                let button = UIButton(type: .system)
//                button.setTitle("我要睡了", for: .normal)
//                button.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
//                button.center = wakeUpViewController.view.center
//                button.addTarget(self, action: #selector(sleepButtonTapped), for: .touchUpInside)
//
//                wakeUpViewController.view.addSubview(button)
//
//                rootViewController.present(wakeUpViewController, animated: true, completion: nil)
//            }
//
//            @objc func sleepButtonTapped() {
//                print("按下睡覺按鈕")
//            }
//
//            // 在這裡處理接收到的推播通知
//            func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//                if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
//                    // 使用者點擊了通知，顯示你想要的視圖
//                    showWakeUpView()
//                }
//
//                completionHandler()
//            }
    }
}
