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
//    @Binding var WalkTaskName : String
//    @Binding var RunTaskName : String
    
    var body: some View {
        NavigationStack {
            Text("123")
//            Text(WalkTaskName)
            Text("You entered: \(TaskName)")
//            Text("You entered: \(WalkTaskName)")
//            Text("You entered: \(RunTaskName)")
        }.navigationTitle("運動")
            .onAppear {
                self.GetDetails()
            }
    }
    
    // 印出details
    private func GetDetails() {
//        getTask_name = TaskDetails.task_name
    }
}
//
struct getDetails_Previews: PreviewProvider {
    @State static var TaskName : String = "Some String"
    static var previews: some View {
        getDetails(TaskName: $TaskName)
    }
}
