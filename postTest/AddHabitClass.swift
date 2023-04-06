//
//  AddHabitClass.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddHabitClass: View {
    
    @State private var showingSheet = false
    
    @State var taskNames: [String] = []

    var body: some View {
        
        NavigationStack {
            ForEach(taskNames, id: \.self) { taskName in
                Button(taskName) {
                          showingSheet.toggle()
                      }
                      .sheet(isPresented: $showingSheet) {
                          AddSportWalk()
                      }
//                Text(taskName)
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
//            @State private var showingSheet = false
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

        
        let url = URL(string: "http://localhost:8888/habitList/liveList.php")!
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
}

struct AddHabitClass_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitClass()
    }
}
