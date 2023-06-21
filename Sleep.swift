//
//  Sleep.swift
//  postTest
//
//  Created by 呂沄 on 2023/5/12.
// 尚未寫一天只能按一次的判斷

import SwiftUI

struct Sleep: View {
//    @State private var isSleep = true
//    @State var classification: Int = 0
    
    @State var set_date: Date = Date()
    @State var Set_date: String = ""
    
    @State var set_time: Date = Date()
    @State var Set_time: String = ""
    
    @State var set_up_time: Date = Date()
    @State var Set_up_time: String = ""
    
    @State private var showOtherView = false
    
    @State var Conitnuous_Days: String = ""
    struct ContinuousDays : Codable {
        var continuousDays:String
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Button(action: {
//                    classification = 0
//                    isSleep = false
                    self.setTime()
                    newSportHabit()
//                        Set_date = dateToDateString(set_date)
//                        Set_time = alertToDateString(set_time)
//                        Set_up_time = setToDateString(set_up_time)
                    print("我要睡了")
                }) {
                    HStack {
                        Text("我要睡了")
                            .fontWeight(.semibold)
                            .font(.title)
                        Image(systemName: "bed.double.fill")
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(40)
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
            .navigationTitle("我要睡了")
        }
        .onAppear{
//            self.tableName()
            DispatchQueue.main.async {
                self.tableName()
                DispatchQueue.main.async {
                    self.judgeDate()
                }
            }
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
    
    private func judgeDate() {
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
            // handle response
            
//            if let data,
//              let content = String(data: data, encoding: .utf8) {
//               print(content)
//                Conitnuous_Days = content
//                print("連續天數：\(content)")
//                print("連續天數Conitnuous_Days：\(Conitnuous_Days)")
//            }
            
            do {
                    // handle response
                    if let data = data,
                       let content = String(data: data, encoding: .utf8) {
                        print(content)
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let continuousDays = jsonData?["continuousDays"] as? String
                        Conitnuous_Days = continuousDays ?? "無法辨識"
                        print("連續天數：\(Conitnuous_Days)")
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
    
    
    
//    private func judgeDate() {
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
//        let url = URL(string: "http://127.0.0.1:8888/judge/judgeDate.php")!
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
//            do {
//                if let data = data {
//                    let content = String(data: data, encoding: .utf8)
//                    print(content)
//                    if let jsonString = content,
//                       let jsonData = jsonString.data(using: .utf8) {
//                        // 解析 JSON 數據
//                        let decoder = JSONDecoder()
//                        do {
//                            let continuousDays = try decoder.decode(ContinuousDays.self, from: jsonData)
//                            print("連續天數：\(continuousDays.continuousDays)")
//                            Conitnuous_Days = continuousDays.continuousDays
//                            print("連續天數C：\(Conitnuous_Days)")
//                        } catch {
//                            print("Error decoding JSON: \(error)")
//                        }
//                    }
//
////                    let decoder = JSONDecoder()
////                    let continuous_days = try decoder.decode(ContinuousDays.self, from: data)
////                    print("連續天數：\(continuous_days.continuousDays)")
////                    Conitnuous_Days = continuous_days.continuousDays
////                    print("連續天數C：\(Conitnuous_Days)")
//                }
//
//                if let error = error {
//                    throw error // 拋出錯誤以進行後續處理
//                }
//
//                guard let data = data else {
//                    return
//                }
//
//                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
//
//                if let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String {
//                    if status == "success" {
//                        // 登錄成功
//                    } else {
//                        print("Registration failed")
//                    }
//                }
//            } catch {
//                print("Error: \(error)") // 處理錯誤
//            }
//        }.resume()
//    }
    
    private func tableName() {
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
        let url = URL(string: "http://127.0.0.1:8888/judge/tableName_Sleep.php")!
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
    
    private func newSportHabit() {
        let url = URL(string: "http://127.0.0.1:8888/addHabits/Sleep.php")!
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

struct Sleep_Previews: PreviewProvider {
    static var previews: some View {
        Sleep()
    }
}
