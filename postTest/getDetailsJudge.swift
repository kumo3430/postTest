//
//  getDetailsJudge.swift
//  postTest
//
//  Created by 呂沄 on 2023/5/17.
//

import SwiftUI

struct getDetailsJudge: View {
    //    @ObservedObject var List: SportListView
    
    //    @State private var getTask_name = ""
    //    @State private var get_classification:Int = 0
    @State private var get_classification = ""
    @State private var Get_classification = ""
    //    @State private var get_sub_classification:Int = 0
    @State private var get_sub_classification = ""
    @State private var Get_sub_classification = ""
    @State private var getTartet_time  = ""
    @State private var getAlert_time = ""
    @State private var getNote = ""
    
    @State var revise_time: Date = Date()
    @State var Revise_time: String = ""
    @State private var tartet_time: Date = Date()
    @State var alert_time: Date = Date()
    @State var alert_time_s: Date = Date()
    @State var alert_time_w: Date = Date()
    @State var Alert_time: String = ""
    @State var Alert_time_s: String = ""
    @State var Alert_time_w: String = ""
    @State var Set_up_time: String = ""
    @State var GetTaskName: String = ""
    
    
    @Binding var TaskName : String
    @Binding var tableName : String
    //    @State private var tableName = ""
    
    @State private var selectedDate = Date()
    
    struct TaskDetails : Decodable {
        var _classification : String
        var _sub_classification: String
        var task_name: String
        var target_time: String
        var alert_time: String
        var note: String
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    Group {
                        VStack {
                            HStack{
                                Text("類別：")
                                Text(get_sub_classification)
                            }
                            HStack{
                                Text("名稱：")
                                Text(TaskName)
                            }
                        }
                        HStack {
                            VStack {
                                if get_sub_classification == "2" {
                                    VStack {
                                        Text("名稱：")
                                    }
                                } else {
                                    VStack {
                                        DatePicker("目標時間：", selection:  $tartet_time, displayedComponents: .hourAndMinute)
                                            .environment(\.locale, Locale.init(identifier: "zh-TW"))
                                        DatePicker("提醒預備時間：", selection:
                                                    $alert_time,displayedComponents: .hourAndMinute)
                                        .environment(\.locale, Locale.init(identifier: "zh-TW"))
                                    }
                                }
                            }
                        }
                        HStack {
                            Text("備注：")
                            // 將帳號密碼的資料存放到LoginInsertViewModel的password
                            TextField("備注", text:$getNote)
                                .textFieldStyle(.roundedBorder)
                            //                                .keyboardType(.numberPad)
                                .padding()
                        }
                    }
                    .padding(12)
                    .background(Color.white)
//                    .onAppear {
//                        Task {
//                            await order()
//                            print(tartet_time)
//                            print(66666666666)
//                        }
//                    }
                    Button{
                        Revise_time = setToDateString(revise_time)
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
                    
                    
                }
                .navigationTitle("建立作息習慣")
            }
            .onAppear {
                Task {
                    await getRoutineTask()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "HH:mm"
                    let tartetTimeString = formatter.string(from: tartet_time)
                    let alertTimeString = formatter.string(from: alert_time)
                    print("tartetTimeString\(tartetTimeString)")
                    print("alertTimeString\(alertTimeString)")
                }
            }
        }
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
    
    private func getRoutineTask() async {
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
        
        let url = URL(string: "http://127.0.0.1:8888/habitList/getTask/getRoutineTask.php")!
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
                    print("任務名稱：\(taskDetails.task_name)")
                    print("大類別：\(taskDetails._classification)")
                    print("小類別：\(taskDetails._sub_classification)")
                    print("目標時間：\(taskDetails.target_time)")
                    print("提醒時間：\(taskDetails.alert_time)")
                    print("備注：\(taskDetails.note)")
                    get_sub_classification = taskDetails._sub_classification
                    getTartet_time = taskDetails.target_time
                    print(getTartet_time)
                    getAlert_time = taskDetails.alert_time
                    getNote = taskDetails.note
                    print("============== taskDetails ==============")
                    print("任務名稱：\(taskDetails.task_name)")
                    print("大類別：\(taskDetails._classification)")
                    print("小類別：\(get_sub_classification)")
                    print("目標時間：\(getTartet_time)")
                    print("提醒時間：\(getAlert_time)")
                    print("備注：\(getNote)")
                    print("============== taskDetails ==============")
                    let formatter = DateFormatter()
                    formatter.timeZone = TimeZone.current
                    formatter.dateFormat = "HH:mm:ss"
                    if let defaultDate = formatter.date(from: getTartet_time) {
                        tartet_time = defaultDate
                        print(formatter.string(from: tartet_time))
                        print(tartet_time)
                    } else {
                        print("無法解析目標時間：\(getTartet_time)")
                    }
                    if let defaultDate = formatter.date(from: getAlert_time) {
                        alert_time = defaultDate
                        print(formatter.string(from: alert_time))
                        print(alert_time)
                    } else {
                        print("無法解析提醒時間：\(getAlert_time)")
                    }
                } catch {
                    print("解碼失敗：\(error)")
                }
            } catch {
                print(error.localizedDescription)
                print(String(describing: error))
            }
        }.resume()
    }
    
    // 新增修改時間
    private func reviseRoutineTask() {
        let url = URL(string: "http://127.0.0.1:8888/addHabits/addRoutineSleep.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body : [String: Any] = ["revise_time": Set_up_time,"task_name": TaskName,"target_time": tartet_time,"note": getNote,"alert_time": Alert_time,"alert_time_w": Alert_time_w,"alert_time_s": Alert_time_s]
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
}


struct getDetailsJudge_Previews: PreviewProvider {
    @State static var TaskName : String = "TaskName"
    @State static var TableName : String = "TableName"
    static var previews: some View {
        getDetailsJudge(TaskName: $TaskName,tableName: $TableName)
    }
}
