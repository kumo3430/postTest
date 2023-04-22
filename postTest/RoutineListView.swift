//
//  SportListView.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/11.
//

import SwiftUI

struct RoutineListView: View {
//    @State var _sub_classification: Int = 1
//    @State private var _sub_classification = 1
    @State private var showingSheet = false
    @State private var ShowingSheet = false
    
    @State var taskNames: [String] = []
    @State private var TaskName = ""
    @State var sleepTaskNames: [String] = []
    @State var sugarTaskNames: [String] = []
    
    @State private var tableName = ""
    
    var body: some View {
        NavigationStack {
            //"健走","跑步","游泳","騎車"
            Text("早睡")
            ForEach(sleepTaskNames, id: \.self) { taskName in
                Button(taskName) {
                    TaskName = taskName
                          ShowingSheet.toggle()
                    print(TaskName)
                      }
                      .sheet(isPresented: $ShowingSheet) {
                          getDetails(TaskName: $TaskName,tableName: $tableName)
                      }
            }
            Text("減糖")
            ForEach(sugarTaskNames, id: \.self) { taskName in
                Button(taskName) {
                    TaskName = taskName
                          ShowingSheet.toggle()
                    print(TaskName)
                      }
                      .sheet(isPresented: $ShowingSheet) {
                          getDetails(TaskName: $TaskName,tableName: $tableName)
                      }
            }
            .navigationTitle("運動類別")
        }
        .onAppear {
            TableName()
            self.get_sub_classification()
//            self.liveList()
        }
    }
    private func TableName() {
        tableName = "routine"
    }
    private func get_sub_classification() {
        for i in 0 ... 4 {
            let _sub_classification = i
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
            let url = URL(string: "http://127.0.0.1:8888/habitList/nameList/liveList.php")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
    //        let body : [String: Any] = ["_sub_classification": _sub_classification]
            let body : [String: Any] = ["_sub_classification": _sub_classification, "tableName": tableName]
//            print(body)
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
                        if (i==0) {
                            self.sleepTaskNames = taskNames
                        }else if(i==1) {
                            self.sugarTaskNames = taskNames
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}

struct RoutineListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineListView()
    }
}
