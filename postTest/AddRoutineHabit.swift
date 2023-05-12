//
//  AddSportWalk.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI
import UserNotifications

//func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//    // 請求推播通知權限
//    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
//        if granted {
//            print("使用者已同意推播通知")
//        } else {
//            print("使用者未同意推播通知")
//        }
//    }
//
//    return true
//}

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

    
    @State private var chooseTag = false
    @State private var notificationScheduled = false
    @State var showSleepView = false

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
//                                            .onAppear {
//                                                timeDifference = Double(targetQuantity * 60) * 60
//                                                let calendar = Calendar.current
//                                                let newTime = calendar.date(byAdding: .second, value: Int(timeDifference!), to: alert_time_s)!
//                                                alert_time_w = newTime
//                                            }
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
//                            DatePicker("提醒預備時間：", selection: $alert_time,displayedComponents: .hourAndMinute)
//                                .environment(\.locale, Locale.init(identifier: "zh-TW"))
//                            
//                        }
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
                        newSportHabit()
//                        setNotification()
                        scheduleNotificationIfNeeded()
                        dismiss()

                    } label: {
                        HStack{
                            Spacer()
//                            NavigationLink(destination: livesView()) {
//                                Text("完成")
//                                    .foregroundColor(.white)
//                                    .padding(.vertical, 10)
//                                    .font(.system(size: 14,weight: .semibold))()
//                            }
                            
                            Text("完成")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14,weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                }
                .navigationTitle("建立作息習慣")
            }
            
        }
    }
    
//    func setNotification(){
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, _) in
//            if granted {
//                //用户同意我们推送通知
//                print("用户已同意推送通知")
//            }else{
//                //用户不同意
//                print("用户未同意推送通知")
//            }
//        }
//    }
    
    private func add() {
//        let calendar = Calendar.current
//        alert_time_w = calendar.date(byAdding: .hour, value: targetQuantity, to: alert_time_s)!

    }
    private func sugar() {
//        target_time = "NULL"
    }
    
    private func dateToDateString() {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd"
//        Begin = formatter.string(from: begin)
//        Finish = formatter.string(from: finish)
//        print(Begin)
//        print(Finish)
//        return date
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
            
            let content = UNMutableNotificationContent()
            content.title = "推播通知標題"
            content.body = "推播通知內容"
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: alert_time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
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
