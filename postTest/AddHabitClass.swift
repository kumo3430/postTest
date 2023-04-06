//
//  AddHabitClass.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddHabitClass: View {
    
    @State private var showingSheet = false
    @State private var ShowingSheet = false
    
    @State var taskNames: [String] = []
    
    @State private var TaskName = ""

    var body: some View {
        
        NavigationStack {
            ForEach(taskNames, id: \.self) { taskName in
//                TaskName = taskName
//                NavigationLink {
//                    getDetails()
//                } label: {
//                    Text(taskName)
//                    self.GetDetails()
//                }

//                NavigationLink(taskName) {
//                    getDetails()
//                }

                Button(taskName) {
                    TaskName = taskName
                          ShowingSheet.toggle()
                        self.GetTaskName()
                    print(TaskName)
                      }
                      .sheet(isPresented: $ShowingSheet) {
                          getDetails()
                      }
            }

//            VStack{
//                NavigationLink("學習") {
////                    AddStudyGeneral()
//                }
//                NavigationLink("運動") {
////                    AddSportWalk(viewModel: SportWalkInsertViewModel())
//                    AddSportWalk()
//                }
//            }
//            @State private var showinmn nnngSheet = false
            Button("運動") {
                      showingSheet.toggle()
                  }
                  .sheet(isPresented: $showingSheet) {
                      AddSportWalk()
                  }

            .navigationTitle("習慣建立")
        }
        .onAppear {
            self.liveList()
        }

    }
    
    private func liveList() {
        
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
                    self.taskNames = taskNames
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    // 把taskName傳入php以便之後印出details
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
        let body = ["taskName": TaskName]
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

struct AddHabitClass_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitClass()
    }
}
