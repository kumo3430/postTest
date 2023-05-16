//
//  AddSportWalk.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI
import UserNotifications

struct AddRoutineHabit: View {
//    @ObservedObject var viewModel: SportWalkInsertViewModel
//    @ObservedObject var viewModel: AddHabitClass
    @State var set_up_time: Date = Date()
//    let classification = ["學習","運動","生活","作息"]
    @State var _classification: Int = 3
    let sub_classification = ["早睡","早起","區間"]
    @State var _sub_classification: Int = 0
//    let Target = ["甜食","飲料"]
//    @State var target: Int = 0
    @State var task_name: String = ""
    @State var tag_id1: Int = 0     //
    @State var quantity: Int = 0
    @State var begin: Date = Date()     //
    @State var finish: Date = Date()        //
    //@State var fulfill: Int = 0
    let cycle = ["日","週","月"]
    @State var note: String = ""
    @State var alert_time: Date = Date()
    @State var alert_time_s: Date = Date()
    @State var alert_time_w: Date = Date()
    //@State var show_to_club: String = ""
    //@State var completion: Int = 0
    @State var uid: Int = 0     //
    @State var Alert_time: String = ""
    @State var Alert_time_s: String = ""
    @State var Alert_time_w: String = ""
    @State var Set_up_time: String = ""
    
    @State var Add: String = ""
    @State var Sub: String = ""
    
    
//    @State var target: String = ""
    @State private var target_quantity: Int = 0
    @State var timeDifference: TimeInterval?

    @State private var target_time: Date = Date()
    @State private var Target_time: String = ""
    
    @State private var subClassification = 0
    @State private var targetTime = Date()
//    @State private var target = "Target 1"
    @State private var target : Int = 0
//    @State private var target_number: Int = 0
    @State private var targetQuantity = 0

//    @State private var content: String = ""
    @State private var chooseTag = false
    @State private var notificationScheduled = false
    @State var showSleepView = false
    
    @State var num: String = ""
    @State var error = false


    @Environment(\.dismiss) var dismiss
    
    func dateToDateString(_ date:Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd  HH:mm:ss"
        let date = formatter.string(from: date)
        return date
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    Group {
                        HStack {
                        Text("類別：")
                            Picker(selection: $_sub_classification, label: Text("選擇大類別")) {
                                ForEach(0 ..< sub_classification.count) {
                                    Text(sub_classification[$0]).tag($0)
                                }
                            }
                        }
                        HStack {
                            Text("名稱：")
                            TextField("習慣名稱", text:$task_name)
                                .textFieldStyle(.roundedBorder)
//                                .keyboardType(.numberPad)
                                .padding()
                        }
                        HStack {
//                            Text("標籤：")
//                            Button("選擇標籤") {
//                                        chooseTag.toggle()
//                                    }
//                                    .sheet(isPresented: $chooseTag) {
//                                        ChooseTag(viewModel: TagInsertViewModel())
//                                    }
                        }
                        HStack {
                            VStack {
                                if _sub_classification == 2 {
                                    VStack {
//                                        IntervalView(targetQuantity: $targetQuantity)
                                        HStack {
                                            Text("我要睡滿")
                                            TextField("n", value: $targetQuantity, formatter: NumberFormatter())
                                                .keyboardType(.numberPad)
                                                .textFieldStyle(.roundedBorder)
                                            Text("小時！！")
                                        }
                                        DatePicker("預計睡覺時間：", selection: $alert_time_s,displayedComponents: .hourAndMinute)
                                            .environment(\.locale, Locale.init(identifier: "zh-TW"))
                                        DatePicker("預計起床時間：", selection: $alert_time_w,displayedComponents: .hourAndMinute)
                                            .environment(\.locale, Locale.init(identifier: "zh-TW"))
                                    }
                                    .onChange(of: alert_time_s, perform: { _ in
                                                // 計算第二個日期選擇器的預設值
                                                let calendar = Calendar.current
                                                let offsetComponents = DateComponents(hour: targetQuantity)
                                                let newDate = calendar.date(byAdding: offsetComponents, to: alert_time_s) ?? alert_time_s
                                                // 更新第二個日期選擇器的變數
                                        alert_time_w = newDate
                                            })
                                } else {
                                    VStack {
                                        SleepView(targetTime: $target_time)
                                        DatePicker("提醒預備時間：", selection: $alert_time,displayedComponents: .hourAndMinute)
                                            .environment(\.locale, Locale.init(identifier: "zh-TW"))
                                    }
                                }
                            }
                        }
                        HStack {
                            Text("備注：")
                            // 將帳號密碼的資料存放到LoginInsertViewModel的password
                            TextField("備注", text:$note)
                                .textFieldStyle(.roundedBorder)
//                                .keyboardType(.numberPad)
                                .padding()
                        }
//                        HStack {
//                            Text("分享社群：")
//                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button{
                        dateToDateString()
                        Alert_time = alertToDateString(alert_time)
                        Alert_time_s = alertToDateString(alert_time_s)
                        Alert_time_w = alertToDateString(alert_time_w)
                        Target_time = alertToDateString(target_time)
//                        alertToDateString()
                        Set_up_time = setToDateString(set_up_time)
//                        setToDateString()
                        if (num == "0") {
                            error = false
                            newSportHabit()
                            scheduleNotificationIfNeeded()
                            dismiss()
    //                        setNotification()
    //                        if _sub_classification == 0 {
    //                            scheduleNotificationIfNeeded_0()
    //                        }
    //                        scheduleNotificationIfNeeded_0()
                        } else {
                            error = true
                        }
                    } label: {
                        HStack{
                            Spacer()
                            Text("完成")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14,weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                    if(error == true) {
                        Text("已重複建立")
                            .foregroundColor(.red)
                    }
                }
                .navigationTitle("建立作息習慣")
            }
            
        }
    }
    
    private func dateToDateString() {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd"
    }
    
    private func alertToDateString(_ date: Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        print(dateString)
        return dateString
    }
    private func setToDateString(_ date: Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        print(dateString)
        return dateString
    }
    private func judge() {
        let url = URL(string: "http://127.0.0.1:8888/addHabits/addRoutineSleep_judge.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print(target)
        let body : [String: Any] = ["_sub_classification": _sub_classification]
        print(body)
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle response
            if let data,
              let content = String(data: data, encoding: .utf8) {
                num = content
               print(num)
            }
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String else { return }
                if status == "success" {
//                    self.isLoggedIn = true
                } else {
                    print("Registration failed")
                }
            } catch {
//                print(error.localizedDescription)
                print(String(describing: error))
            }
        }.resume()
    }
    
    private func newSportHabit() {
        let url = URL(string: "http://127.0.0.1:8888/addHabits/addRoutineSleep.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print(target)
        let body : [String: Any] = ["_classification":_classification,"set_up_time": Set_up_time,"_sub_classification": _sub_classification,"task_name": task_name,"tag_id1": tag_id1,"target_time": Target_time,"target_quantity": targetQuantity,"note": note,"alert_time": Alert_time,"alert_time_w": Alert_time_w,"alert_time_s": Alert_time_s]
        print(body)
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle response
            if let data,
              let content = String(data: data, encoding: .utf8) {
               print(content)
            }
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String else { return }
                if status == "success" {
//                    self.isLoggedIn = true
                } else {
                    print("Registration failed")
                }
            } catch {
//                print(error.localizedDescription)
                print(String(describing: error))
            }
        }.resume()
    }
    
    private func scheduleNotificationIfNeeded() {
        guard !notificationScheduled else {
            return
        }
        var content = UNMutableNotificationContent()
        if _sub_classification == 0 {
            content.title = "該睡覺了！！"
            content.body = "該放下手機 準備該睡覺了囉～"
            content.sound = UNNotificationSound.default
            print(content.title)

        } else if _sub_classification == 1 {
            content.title = "該起床了！！"
            content.body = "太陽曬屁股了 快點起床！"
            content.sound = UNNotificationSound.default
            print(content.title)
        }
    
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: alert_time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
//    let request = UNNotificationRequest(identifier: "YourNotificationIdentifier", content: UNMutableNotificationContent(), trigger: trigger)
            let request = UNNotificationRequest(identifier: "YourNotificationIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("無法設定推播通知: \(error)")
            } else {
                print("推播通知已設定")
                notificationScheduled = true
            }
        }
    }
    
    private func scheduleNotificationIfNeeded_0() {
        guard !notificationScheduled else {
            return
        }

        let content = UNMutableNotificationContent()
        content.title = "該睡覺了～～"
        content.body = "該放下手機 準備該睡覺了囉～"
        content.sound = UNNotificationSound.default

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: alert_time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

//        let request = UNNotificationRequest(identifier: "YourNotificationIdentifier", content: UNMutableNotificationContent(), trigger: trigger)
                    let request = UNNotificationRequest(identifier: "YourNotificationIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("無法設定推播通知: \(error)")
            } else {
                print("推播通知已設定")
                notificationScheduled = true
            }
        }
    }
}

struct AddRoutineHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineHabit()
    }
}
