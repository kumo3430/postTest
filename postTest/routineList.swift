//
//  routineList.swift
//  postTest
//
//  Created by 呂沄 on 2023/6/8.
//

import SwiftUI

struct routineList: View {
    @State var tableName: String = ""
    @State private var showingSheetSleep = false
    @State private var showingSheetWakeUp = false
    @State private var showingSheetiInterval = false
    
    @State var taskNames: [String] = []
    @State private var TaskName = ""
    @State var sleepTaskNames: [String] = []
    @State var wakeUpTaskNames: [String] = []
    @State var intervalTaskNames: [String] = []
    
    var body: some View {
        NavigationStack {
            //"健走","跑步","游泳","騎車"
//            Text("早睡")
            ForEach(sleepTaskNames.indices, id: \.self) { index in
                let taskName = sleepTaskNames[index]
                Text(taskName)
            }
            .navigationTitle("查看紀錄")
        }
        .onAppear {
            self.get_sub_classification()
//            self.liveList()
        }
    }
    
    private func get_sub_classification() {
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
            let url = URL(string: "http://127.0.0.1:8888/habitList/nameList/routineList.php")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
    //        let body : [String: Any] = ["_sub_classification": _sub_classification]
            let body : [String: Any] = [ "tableName": tableName]
////            print(body)
            let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
    //        URLSession.shared.dataTask(with: request) { data, response, error in
        URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data returned from server.")
                return
            }
            if let content = String(data: data, encoding: .utf8) {
                print(content)
                let jsonData = content.data(using: .utf8)!
                do {
                    let decoder = JSONDecoder()
                    let taskNames = try decoder.decode([String].self, from: jsonData)
//                    let taskNames = try decoder.decode([String].self, from: data)
                   
                        self.sleepTaskNames = taskNames
                    
                } catch {
//                        print(error.localizedDescription)
                }
            }
            }.resume()
    }
}

struct routineList_Previews: PreviewProvider {
    static var previews: some View {
        routineList()
    }
}
