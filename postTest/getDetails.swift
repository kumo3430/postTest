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
    
    var body: some View {
        NavigationStack {
            Text("123")
        }.navigationTitle("運動")
            .onAppear {
                self.GetDetails()
            }
    }
    
    // 印出details
    private func GetDetails() {
//        getTask_name = $List.TaskDetails.task_name
    }
}

struct getDetails_Previews: PreviewProvider {
    static var previews: some View {
        getDetails()
    }
}
