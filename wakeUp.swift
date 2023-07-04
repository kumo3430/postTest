//
//  wakeUp.swift
//  postTest
//
//  Created by 呂沄 on 2023/5/15.
//

import SwiftUI

struct wakeUp: View {
    @State private var isReady = false
    @State var set_date: Date = Date()
    @State var Set_date: String = ""
    
    @State var set_time: Date = Date()
    @State var Set_time: String = ""
    
    @State var set_up_time: Date = Date()
    @State var Set_up_time: String = ""
    
    @State private var showOtherView = false
    @State var Conitnuous_Days: String = ""
    struct ContinuousDays : Decodable {
        var continuousDays:Int
    }
    @State var already: String = ""
//    @State var Already = false
    struct Message : Decodable {
        var message:String
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Button(action: {
                    self.setTime()
                    newSportHabit()
                    print("我醒來了")
                    Task {
                        await judgeDate()
                    }
                    
                }) {
                    VStack {
                        HStack {
                            Text("我醒來了")
                                .fontWeight(.semibold)
                                .font(.title)
                            Image(systemName: "sunrise.circle.fill")
                                .font(.title)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
//                        if (Already) {
                        if (already != "") {
                            Text(already)
                                .foregroundColor(.red)
                        }
                    }
                    
                }
                Spacer()
                Button(action: {
//                    routineList()
                    showOtherView = true
                }) {
                    HStack {
                        Text("查看紀錄")
                            .fontWeight(.semibold)
                            .font(.title)
                        Image(systemName: "doc.plaintext")
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                }
                .sheet(isPresented: $showOtherView) {
                    routineList()
                }
                Spacer()
                VStack(alignment:.leading) {
                    HStack {
                        Text("連續天數：")
//                        Text(String(Conitnuous_Days))
                        Text("\(Conitnuous_Days)")
                    }
                    .padding()
                    .foregroundColor(.red)
                    HStack {
                        Text("今日日期：")
                        Text(Date(), style: .date)
                    }
                    .padding()
                    HStack {
                        Text("當下時間：")
                        Text(Date(), style: .time)
                    }
                    .padding()
                }
                .frame(alignment: .trailing)
                .fontWeight(.bold)
                .font(.title)
                .padding()
                Spacer()
                Spacer()
            }
            .navigationTitle("我醒來了")
        }
        .onAppear{
            Task {
                await first()
            }
        }
    }
    
//    private func first() {
////        let serialQueue = DispatchQueue(label: "serialQueue")
////        serialQueue.sync {
////            tableName()
////        }
////        serialQueue.sync {
////            judgeDate()
////        }
//        DispatchQueue.global(qos: .background).sync {
//            tableName()
//        }
//        DispatchQueue.global(qos: .userInteractive).async {
//            judgeDate()
//        }
//    }
    func first() async {
        do {
            let name = try await tableName()
            print("Table name: \(name)")

            // Call judgeDate() after tableName() completes
//            try await judgeDate()
            await judgeDate()
            print("judgeDate() completed after tableName()")
        } catch {
            print("Error: \(error)")
        }
    }


    
    private func setTime() {
        Set_date = dateToDateString(set_date)
        Set_time = alertToDateString(set_time)
        Set_up_time = setToDateString(set_up_time)
    }
    
    private func dateToDateString(_ date: Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        print(dateString)
        return dateString
    }
    
    private func alertToDateString(_ date: Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
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
    private func judgeDate() async {
//    private func judgeDate() {
        print("2")
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
        let url = URL(string: "http://127.0.0.1:8888/judge/judgeDate.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        let body = ["taskName": TaskName, "tableName": tableName]
        // 建立空的 body
        let body: [String: Any] = [:]
        // 將 body 轉換為 JSON 資料
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
//        URLSession.shared.dataTask(with: request) { data, response, error in
        // 使用 URLSessionSingleton 的 shared 實例發送請求
        URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
            do {
                    // handle response
                    if let data = data,
                       let content = String(data: data, encoding: .utf8) {
                        print(content)
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let continuousDays = jsonData?["continuousDays"] as? String
                        Conitnuous_Days = continuousDays ?? "無法辨識"
                        print("連續天數：\(Conitnuous_Days)")
                        print("------------------------")
                    }
                    // ...
                } catch {
                    print(error.localizedDescription)
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
//    private func tableName() async throws -> String {
////    private func tableName() {
//        print("1")
//        class URLSessionSingleton {
//            static let shared = URLSessionSingleton()
//            let session: URLSession
//            private init() {
//                let config = URLSessionConfiguration.default
//                config.httpCookieStorage = HTTPCookieStorage.shared
//                config.httpCookieAcceptPolicy = .always
//                session = URLSession(configuration: config)
//            }
//        }
//        let url = URL(string: "http://127.0.0.1:8888/judge/tableName_WakeUp.php")!
//
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let name = String(data: data, encoding: .utf8)!
////        return name
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
////        let body = ["taskName": TaskName, "tableName": tableName]
//        // 建立空的 body
//        let body: [String: Any] = [:]
//        // 將 body 轉換為 JSON 資料
//        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
//        request.httpBody = jsonData
////        URLSession.shared.dataTask(with: request) { data, response, error in
//        // 使用 URLSessionSingleton 的 shared 實例發送請求
//        URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
//            // handle response
//            if let data,
//              let content = String(data: data, encoding: .utf8) {
//               print(content)
//            }
//            guard let data = data else { return }
////            print(String(data: data, encoding: .utf8)!)
//            do {
//                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
//                guard let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String else { return }
//                if status == "success" {
////                    self.isLoggedIn = true
//                } else {
//                    print("Registration failed")
//                }
//            } catch {
////                print(error.localizedDescription)
//                print(String(describing: error))
//            }
//        }.resume()
////        await judgeDate()
//        return name
//    }
    private func tableName() async throws -> String {
   //    private func tableName() {
           print("1")
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
           let url = URL(string: "http://127.0.0.1:8888/judge/tableName_WakeUp.php")!
   
           let (data, _) = try await URLSession.shared.data(from: url)
           let name = String(data: data, encoding: .utf8)!
           return name
       }
    
    
    private func newSportHabit() {
        let url = URL(string: "http://127.0.0.1:8888/addHabits/WakeUp.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body : [String: Any] = ["set_date": Set_date,"set_time": Set_time,"set_up_time": Set_up_time]
//        print(body)
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle response
            if let data,
              let content = String(data: data, encoding: .utf8) {
               print(content)
                
                let decoder = JSONDecoder()
                do {
                    let judge = try decoder.decode(Message.self, from: data)
                    print("============== wakeUP message ==============")
                    print(judge)
                    print("message：\(judge.message)")
                    if (judge.message == "you had built") {
                        self.already = "今日已新增過了"
                    }
//                    Already = true
                    print("============== wakeUP message ==============")
                } catch {
                    print("解碼失敗：\(error)")
                }
                
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
}

struct wakeUp_Previews: PreviewProvider {
    static var previews: some View {
        wakeUp()
    }
}
