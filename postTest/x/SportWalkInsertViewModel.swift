////
////  SportWalkInertViewModel.swift
////  LoginTest
////
////  Created by 呂沄 on 2023/2/13.
////
//
//import Foundation
//
//class SportWalkInsertViewModel: ObservableObject {
//    @Published var allLive: [Lives] = []
//    
//    @Published var set_up_time: Date = Date()
//    @Published var _classification: Int = 0
//    @Published var _sub_classification: Int = 0
//    @Published var task_name: String = ""
//    @Published var tag_id1: Int = 0
//    @Published var quantity: Int = 0
//    @Published var begin: Date = Date()
//    @Published var finish: Date = Date()
//    @Published var fulfill: Int = 0
//    @Published var _cycle: Int = 0
//    @Published var note: String = ""
//    @Published var alert_time: Date = Date()
//    @Published var show_to_club: String = ""
//    @Published var completion: Int = 0
//    @Published var uid: Int = 0
//    
//    // 再點選Button的時候會執行此Funtion
//    func onAddButtonClick() {
//        if task_name != "" {
//            // 變數設定為 (dataStore: viewModel)
//            // 執行 TaskDataStore裡的insert()，並將剛剛輸入的帳號密碼回傳進function
//            let id = LivesDataStore.shared.insert(set_up_time: set_up_time,
//                                                  _classification: _classification,
//                                                  _sub_classification: _sub_classification,
//                                                  task_name: task_name,
//                                                  tag_id1: tag_id1,
//                                                  quantity: quantity,
//                                                  begin: begin,
//                                                  finish: finish,
//                                                  fulfill: fulfill,
//                                                  _cycle: _cycle,
//                                                  note: note,
//                                                  alert_time: alert_time,
//                                                  show_to_club: show_to_club,
//                                                  completion: completion,
//                                                  uid:uid)
//            // （功能保留）
//            /* if id != nil {
//                
//            } */
//        }
//    }
//    
//    func getTaskList() {
//        // 執行 TaskDataStore裡的getAllTasks()
//        allLive = LivesDataStore.shared.getAllTasks()
//    }
//    
//    
//    
//}
