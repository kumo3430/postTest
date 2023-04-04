////
////  List.swift
////  postTest
////
////  Created by 呂沄 on 2023/4/4.
////
//
//import SwiftUI
//
//struct Task: Codable, Identifiable {
//    let id: Int
//    let name: String
//    let completed: Bool
//}
//
//class TasksViewModel: ObservableObject {
//    @Published var tasks: [Task] = []
//
//    func fetchTasks() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let tasks = try decoder.decode([Task].self, from: data)
//                    DispatchQueue.main.async {
//                        self.tasks = tasks
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error.localizedDescription)")
//                }
//            }
//        }.resume()
//    }
//}
//
//
//
//struct List: View {
//    @ObservedObject var viewModel = TasksViewModel()
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.tasks) { task in
//                VStack(alignment: .leading) {
//                    Text(task.name)
//                    Text(task.completed ? "Completed" : "Not completed")
//                        .foregroundColor(task.completed ? .green : .red)
//                }
//            }
//            .navigationBarTitle("Tasks")
//        }
//        .onAppear {
//            self.viewModel.fetchTasks()
//        }
//    }
//}
//
//
//struct List_Previews: PreviewProvider {
//    static var previews: some View {
//        List()
//    }
//}
//
//
