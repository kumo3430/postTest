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

    @State private var target_quantity: Int = 0
    @State var timeDifference: TimeInterval?

    @State private var target_time: Date = Date()
    @State private var Target_time: String = ""
    
    @State private var subClassification = 0
    @State private var targetTime = Date()
    @State private var target : Int = 0
//    @State private var target_number: Int = 0
    @State private var targetQuantity = 0

//    @State private var content: String = ""
    @State private var chooseTag = false
    @State private var notificationScheduled = false
    @State var showSleepView = false
    
    @State var num: String = ""
    @State private var Num : Int = 0
    @State var Error = false


    @Environment(\.dismiss) var dismiss
    
    // 似乎可以把這段程式碼拿掉
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
                                // sub_classification = ["早睡","早起","區間"]
                                ForEach(0 ..< sub_classification.count) {
                                    // ?
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
//                                        SleepView(targetTime: $target_time)
                                        DatePicker("目標時間：", selection: $target_time,displayedComponents: .hourAndMinute)
                                            .environment(\.locale, Locale.init(identifier: "zh-TW"))
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
                        judge()
                        Set_up_time = setToDateString(set_up_time)
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
                    if(Error == true) {
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
    // 判斷是否在資料庫已新增過同樣小類別的資料了
    // 希望可以印出ex: 作息-早睡 已新增過
    private func judge() {
        
        class URLSessionSingleton {
            static let shared = URLSessionSingleton()

            let session: URLSession

            private init() {
                let config = URLSessionConfiguration.default
                config.httpCookieStorage = HTTPCookieStorage.shared
                config.httpCookieAcceptPolicy = .always

                session = URLSession(configuration: config)
            }
        }
        
        let url = URL(string: "http://127.0.0.1:8888/addHabits/addRoutineSleep_judge.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body : [String: Any] = ["_sub_classification": _sub_classification]
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
//        URLSession.shared.dataTask(with: request) { data, response, error in
        URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
            // handle response
            if let data,
              let content = String(data: data, encoding: .utf8) {
                // 如果此類別再資料庫已有一筆資料會印出num:1
                num = content
                if (num == "0") {
                    Num = 0
                } else {
                    Num = 1
                }
               print("num:\(num)")
                print("Num:\(Num)")
                if (num == "0" ) {
                    DispatchQueue.main.async {
                        print("檢查是否有進入此程式碼")
                        Error = false
                        dateToDateString()
                        Alert_time = alertToDateString(alert_time)
                        Alert_time_s = alertToDateString(alert_time_s)
                        Alert_time_w = alertToDateString(alert_time_w)
                        Target_time = alertToDateString(target_time)
                        //                        alertToDateString()
                        Set_up_time = setToDateString(set_up_time)
                        self.newSportHabit()
                        scheduleNotificationIfNeeded()
                        dismiss()
                    }
                } else {
                    DispatchQueue.main.async {
                        Error = true
                        print("已重複建立")
                    }
                }
            }
        }.resume()
    }
    
    private func newSportHabit() {
        
        class URLSessionSingleton {
            static let shared = URLSessionSingleton()

            let session: URLSession

            private init() {
                let config = URLSessionConfiguration.default
                config.httpCookieStorage = HTTPCookieStorage.shared
                config.httpCookieAcceptPolicy = .always

                session = URLSession(configuration: config)
            }
        }
        
        // 建立 URL 物件：
        let url = URL(string: "http://127.0.0.1:8888/addHabits/addRoutineSleep2.php")!
        // 建立 URLRequest 物件：使用剛剛建立的 URL 物件建立一個 URLRequest 物件
        var request = URLRequest(url: url)
        // 設定該請求的 HTTP 方法為 "POST"
        request.httpMethod = "POST"
        // 設定請求的內容：使用一個字典 body 儲存要傳送給伺服器的參數資料
        let body : [String: Any] = ["_classification":_classification,"set_up_time": Set_up_time,"_sub_classification": _sub_classification,"task_name": task_name,"tag_id1": tag_id1,"target_time": Target_time,"target_quantity": targetQuantity,"note": note,"alert_time": Alert_time,"alert_time_w": Alert_time_w,"alert_time_s": Alert_time_s]
        print(body)
        // 轉換為 JSON：將字典 body 轉換為 JSON 格式的資料，存入 jsonData 變數
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        // 設定請求的內容：資料設定為請求的 httpBody，這樣資料就會以 JSON 格式傳送給伺服器
        request.httpBody = jsonData
        // 發送請求並設定一個回呼函式處理回應。當伺服器回應後，回呼函式會被呼叫。
//        URLSession.shared.dataTask(with: request) { data, response, error in
        URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
            // handle response
            if let data,
              let content = String(data: data, encoding: .utf8) {
               print(content)
            }
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
            do {
                // 將回應資料轉換為 JSON 物件，並嘗試將其轉換為字典 dict
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
//                print("Error parsing JSON: \(error.localizedDescription)")
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
