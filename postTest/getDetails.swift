//
//  getDetails.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/6.
//

import SwiftUI

struct getDetails: View {
    
//    @ObservedObject var List: SportListView
    
//    @State private var getTask_name = ""
    @State private var get_sub_classification = ""
    @State private var getBegin = ""
    @State private var getFinish = ""
    @State private var getQuantity = ""
    @State private var get_cycle = ""
    @State private var getNote = ""
    @State private var getAlert_time = ""
    
    @Binding var TaskName : String
    @Binding var tableName : String
//    @State private var tableName = ""
    
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
//        VStack{
//            Text("習慣名稱 : \(TaskName)")
//                .font(.headline)
//                .fontWeight(.bold)
//                .padding(6.0)
//            Text("習慣名稱 : \(TaskName)")
//                .font(.headline)
//                .fontWeight(.bold)
//
//                .padding(6.0)
//        }
        
        NavigationStack {
            VStack{
                Text("大類別 : \(TaskName)")
                    .padding(5.0)
                Text("小類別 : \(get_sub_classification)")
                    .padding(5.0)
                Text("習慣名稱 : \(TaskName)")
                    .padding(5.0)
                Text("開始日期 : \(getBegin)")
                    .padding(5.0)
                Text("結束日期 : \(getFinish)")
                    .padding(5.0)
                HStack{
                    Text("目標 : \(getQuantity) \(get_cycle)")
                        .padding(5.0)
                }
                Text("備注 : \(getNote)")
                    .padding(5.0)
                Text("提醒時間 : \(getAlert_time)")
                    .padding(5.0)
            }
            .multilineTextAlignment(.leading)
            .font(.headline)
            .fontWeight(.bold)


                .navigationTitle(" \(TaskName)")
        }
            .multilineTextAlignment(.center)
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
        request.httpMethod = "POST"
        
        let body = ["taskName": TaskName, "tableName": tableName]
        print(body)
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
            if let data,
              let content = String(data: data, encoding: .utf8) {
               print(content)
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                do {
                    let taskDetails = try decoder.decode(TaskDetails.self, from: data)
                    print("============== taskDetails ==============")
                    print(taskDetails)
                    print("任務名稱為：\(taskDetails.task_name)")
                    print("大類別為：\(taskDetails._sub_classification)")
                    print("小類別為：\(taskDetails._sub_classification)")
                    print("開始日期為：\(taskDetails.begin)")
                    print("結束日期為：\(taskDetails.finish)")
                    print("目標為：\(taskDetails.quantity)")
                    print("週期為：\(taskDetails._cycle)")
                    print("備注為：\(taskDetails.note)")
                    print("提醒時間為：\(taskDetails.alert_time)")
                    get_sub_classification = taskDetails._sub_classification
                    getBegin = taskDetails.begin
                    getFinish = taskDetails.finish
                    getQuantity = taskDetails.quantity
                    get_cycle = taskDetails._cycle
                    getNote = taskDetails.note
                    getAlert_time = taskDetails.alert_time
                    
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
    @State static var TaskName : String = "TaskName"
    @State static var TableName : String = "TableName"
    static var previews: some View {
        getDetails(TaskName: $TaskName,tableName: $TableName)
    }
}
