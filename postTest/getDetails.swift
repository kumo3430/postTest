//
//  getDetails.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/6.
//

import SwiftUI

struct getDetails: View {
    
//    @ObservedObject var List: SportListView
    
    @State private var getTask_name = ""
    @State private var getBegin = ""
    @State private var getFinish = ""
    @State private var getQuantity = ""
    @State private var get_cycle = ""
    @State private var getNote = ""
    @State private var getAlert_time = ""
    
    @Binding var TaskName : String
    @State private var tableName = ""
    
    struct TaskDetails : Decodable {
        var _sub_classification: String
        var task_name: String
        var begin: String
        var finish: String
        var quantity: String
        var _cycle: String
        var note: String
        var alert_time: String
    }
    
    var body: some View {
        NavigationStack {
            Text("123")
//            Text(WalkTaskName)
            Text("You entered: \(TaskName)")
//            Text("You entered: \(WalkTaskName)")
//            Text("You entered: \(RunTaskName)")
        }.navigationTitle("運動")
            .onAppear {
                self.GetTaskName()
            }
    }
    
    private func GetTaskName() {
        
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
       
        let url = URL(string: "http://127.0.0.1:8888/habitList/getTask/getlivesTask.php")!
        var request = URLRequest(url: url)
//        print(url)
//        print(request)
        request.httpMethod = "POST"
        
        tableName = "lives"
        
        let body = ["taskName": TaskName, "tableName": tableName]
        print(body)
//        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
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
//                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
//                guard let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String else { return }
//                if status == "success" {
////                    self.isLoggedIn = true
//                } else {
//                    print("Registration failed")
//                }
                
                let decoder = JSONDecoder()
                do {
                    let taskDetails = try decoder.decode(TaskDetails.self, from: data)
                    print("============== taskDetails ==============")
                    print(taskDetails)
                    print("任務名稱為：\(taskDetails.task_name)")
                    print("============== taskDetails ==============")
                } catch {
                    print("解碼失敗：\(error)")
                }
            } catch {
                print(error.localizedDescription)
                print(String(describing: error))
            }
        }.resume()
        
    }
}
//
struct getDetails_Previews: PreviewProvider {
    @State static var TaskName : String = "Some String"
    static var previews: some View {
        getDetails(TaskName: $TaskName)
    }
}
