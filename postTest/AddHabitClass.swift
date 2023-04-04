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
    @State private var getTaskName = ""

    
    struct List : Codable {
//        var taskName: [String]
        var taskName: String
    }
    
    var body: some View {
        
        NavigationStack {
            ForEach(taskNames, id: \.self) { taskName in
                Text(taskName)
            }
//            liveList()
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
            Text(getTaskName)
        }

    }
    
    private func liveList() {
        let url = URL(string: "http://localhost:8888/habitList/liveList.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        URLSession.shared.dataTask(with: request) { data, response, error in
            
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
