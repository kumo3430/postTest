////
////  LiveListView.swift
////  postTest
////
////  Created by 呂沄 on 2023/4/15.
////
//
//import SwiftUI
//
//struct LiveListView: View {
//    //    @State var _sub_classification: Int = 1
//    //    @State private var _sub_classification = 1
//        @State private var showingSheet = false
//        @State private var ShowingSheet = false
//        
//        @State var taskNames: [String] = []
//        @State private var TaskName = ""
//        
//        @State var walkTaskNames: [String] = []
//        @State private var WalkTaskName = ""
//        
//        @State var runTaskNames: [String] = []
//        @State private var RunTaskName = ""
//        
//        @State var swimTaskNames: [String] = []
//        @State private var SwimTaskNames = ""
//        
//        @State var bikeTaskNames: [String] = []
//        @State private var BikeTaskNames = ""
//        
//        struct TaskDetails : Decodable {
//            var _sub_classification: String
//            var task_name: String
//            var begin: String
//            var finish: String
//            var quantity: String
//            var _cycle: String
//            var note: String
//            var alert_time: String
//        }
//        
//        var body: some View {
//            NavigationStack {
//                //"健走","跑步","游泳","騎車"
//                Text("健走")
//                ForEach(walkTaskNames, id: \.self) { taskName in
//
//                    Button(taskName) {
//                        WalkTaskName = taskName
//                              ShowingSheet.toggle()
//                            self.GetTaskName()
//                        print(WalkTaskName)
//                          }
//                          .sheet(isPresented: $ShowingSheet) {
//                              getDetails(WalkTaskName: $WalkTaskName)
//                          }
//                }
//                Text("跑步")
//                ForEach(runTaskNames, id: \.self) { taskName in
//
//                    Button(taskName) {
//                        RunTaskName = taskName
//                              ShowingSheet.toggle()
//                            self.GetTaskName()
//                        print(RunTaskName)
//                          }
//                          .sheet(isPresented: $ShowingSheet) {
//                              getDetails(WalkTaskName: $WalkTaskName)
//                          }
//                }
//                Text("游泳")
//                ForEach(swimTaskNames, id: \.self) { taskName in
//
//                    Button(taskName) {
//                        SwimTaskNames = taskName
//                              ShowingSheet.toggle()
//                            self.GetTaskName()
//                        print(SwimTaskNames)
//                          }
//                          .sheet(isPresented: $ShowingSheet) {
//                              getDetails()
//                          }
//                }
//                Text("騎車")
//                ForEach(bikeTaskNames, id: \.self) { taskName in
//
//                    Button(taskName) {
//                        BikeTaskNames = taskName
//                              ShowingSheet.toggle()
//                            self.GetTaskName()
//                        print(BikeTaskNames)
//                          }
//                          .sheet(isPresented: $ShowingSheet) {
//                              getDetails()
//                          }
//                }
//
//                .navigationTitle("運動類別")
//            }
//            .onAppear {
//                self.get_sub_classification_0()
//                self.get_sub_classification_1()
//                self.get_sub_classification_2()
//                self.get_sub_classification_3()
//    //            self.liveList()
//            }
//        }
//        private func get_sub_classification_0() {
//            
//            let _sub_classification = 0
//            
//            class URLSessionSingleton {
//                static let shared = URLSessionSingleton()
//
//                let session: URLSession
//
//                private init() {
//                    let config = URLSessionConfiguration.default
//                    config.httpCookieStorage = HTTPCookieStorage.shared
//                    config.httpCookieAcceptPolicy = .always
//
//                    session = URLSession(configuration: config)
//                }
//            }
//
//            let url = URL(string: "http://127.0.0.1:8888/habitList/nameList/liveList.php")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            let body : [String: Any] = ["_sub_classification": _sub_classification]
//            print(body)
//            let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
//            request.httpBody = jsonData
//    //        URLSession.shared.dataTask(with: request) { data, response, error in
//            URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
//                guard let data = data else {
//                    print("No data returned from server.")
//                    return
//                }
//                if let content = String(data: data, encoding: .utf8) {
//                    print(content)
//                    let jsonData = content.data(using: .utf8)!
//                    do {
//                        let decoder = JSONDecoder()
//                        let taskNames = try decoder.decode([String].self, from: jsonData)
//    //                    let taskNames = try decoder.decode([String].self, from: data)
//                        self.walkTaskNames = taskNames
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }.resume()
//        }
//        
//        private func get_sub_classification_1() {
//            
//            let _sub_classification = 1
//            
//            class URLSessionSingleton {
//                static let shared = URLSessionSingleton()
//
//                let session: URLSession
//
//                private init() {
//                    let config = URLSessionConfiguration.default
//                    config.httpCookieStorage = HTTPCookieStorage.shared
//                    config.httpCookieAcceptPolicy = .always
//
//                    session = URLSession(configuration: config)
//                }
//            }
//
//            let url = URL(string: "http://127.0.0.1:8888/habitList/nameList/liveList.php")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            let body : [String: Any] = ["_sub_classification": _sub_classification]
//            print(body)
//            let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
//            request.httpBody = jsonData
//    //        URLSession.shared.dataTask(with: request) { data, response, error in
//            URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
//                guard let data = data else {
//                    print("No data returned from server.")
//                    return
//                }
//                if let content = String(data: data, encoding: .utf8) {
//                    print(content)
//                    let jsonData = content.data(using: .utf8)!
//                    do {
//                        let decoder = JSONDecoder()
//                        let taskNames = try decoder.decode([String].self, from: jsonData)
//    //                    let taskNames = try decoder.decode([String].self, from: data)
//                        self.runTaskNames = taskNames
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }.resume()
//        }
//        
//        private func get_sub_classification_2() {
//            
//            let _sub_classification = 2
//            
//            class URLSessionSingleton {
//                static let shared = URLSessionSingleton()
//
//                let session: URLSession
//
//                private init() {
//                    let config = URLSessionConfiguration.default
//                    config.httpCookieStorage = HTTPCookieStorage.shared
//                    config.httpCookieAcceptPolicy = .always
//
//                    session = URLSession(configuration: config)
//                }
//            }
//
//            let url = URL(string: "http://127.0.0.1:8888/habitList/nameList/liveList.php")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            let body : [String: Any] = ["_sub_classification": _sub_classification]
//            print(body)
//            let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
//            request.httpBody = jsonData
//    //        URLSession.shared.dataTask(with: request) { data, response, error in
//            URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
//                guard let data = data else {
//                    print("No data returned from server.")
//                    return
//                }
//                if let content = String(data: data, encoding: .utf8) {
//                    print(content)
//                    let jsonData = content.data(using: .utf8)!
//                    do {
//                        let decoder = JSONDecoder()
//                        let taskNames = try decoder.decode([String].self, from: jsonData)
//    //                    let taskNames = try decoder.decode([String].self, from: data)
//                        self.swimTaskNames = taskNames
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }.resume()
//        }
//        
//        private func get_sub_classification_3() {
//            
//            let _sub_classification = 3
//            
//            class URLSessionSingleton {
//                static let shared = URLSessionSingleton()
//
//                let session: URLSession
//
//                private init() {
//                    let config = URLSessionConfiguration.default
//                    config.httpCookieStorage = HTTPCookieStorage.shared
//                    config.httpCookieAcceptPolicy = .always
//
//                    session = URLSession(configuration: config)
//                }
//            }
//
//            let url = URL(string: "http://127.0.0.1:8888/habitList/nameList/liveList.php")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            let body : [String: Any] = ["_sub_classification": _sub_classification]
//            print(body)
//            let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
//            request.httpBody = jsonData
//    //        URLSession.shared.dataTask(with: request) { data, response, error in
//            URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
//                guard let data = data else {
//                    print("No data returned from server.")
//                    return
//                }
//                if let content = String(data: data, encoding: .utf8) {
//                    print(content)
//                    let jsonData = content.data(using: .utf8)!
//                    do {
//                        let decoder = JSONDecoder()
//                        let taskNames = try decoder.decode([String].self, from: jsonData)
//    //                    let taskNames = try decoder.decode([String].self, from: data)
//                        self.bikeTaskNames = taskNames
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }.resume()
//        }
//        
//        private func GetTaskName() {
//            
//            class URLSessionSingleton {
//                static let shared = URLSessionSingleton()
//
//                let session: URLSession
//
//                private init() {
//                    let config = URLSessionConfiguration.default
//                    config.httpCookieStorage = HTTPCookieStorage.shared
//                    config.httpCookieAcceptPolicy = .always
//
//                    session = URLSession(configuration: config)
//                }
//            }
//           
//            let url = URL(string: "http://127.0.0.1:8888/habitList/getTask/getlivesTask.php")!
//            var request = URLRequest(url: url)
//    //        print(url)
//    //        print(request)
//            request.httpMethod = "POST"
//            let body = ["taskName": TaskName]
//            print(body)
//    //        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
//            let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
//            request.httpBody = jsonData
//    //        URLSession.shared.dataTask(with: request) { data, response, error in
//            URLSessionSingleton.shared.session.dataTask(with: request) { data, response, error in
//                // handle response
//                if let data,
//                  let content = String(data: data, encoding: .utf8) {
//                   print(content)
//                }
//                guard let data = data else { return }
//    //            print(String(data: data, encoding: .utf8)!)
//                do {
//    //                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
//    //                guard let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String else { return }
//    //                if status == "success" {
//    ////                    self.isLoggedIn = true
//    //                } else {
//    //                    print("Registration failed")
//    //                }
//                    
//                    let decoder = JSONDecoder()
//                    do {
//                        let taskDetails = try decoder.decode(TaskDetails.self, from: data)
//                        print("============== taskDetails ==============")
//                        print(taskDetails)
//                        print("任務名稱為：\(taskDetails.task_name)")
//                        print("============== taskDetails ==============")
//                    } catch {
//                        print("解碼失敗：\(error)")
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                    print(String(describing: error))
//                }
//            }.resume()
//            
//        }
//    }
//
//
//struct LiveListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LiveListView()
//    }
//}
