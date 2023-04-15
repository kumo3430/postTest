//
//  SleepView.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/12.
//

import SwiftUI
struct SleepView: View {
    @Binding var targetTime: Date

//    let target = ""
//    let targetQuantity = 0
    var body: some View {
        DatePicker("目標時間：", selection: $targetTime, displayedComponents: .hourAndMinute)
            .environment(\.locale, Locale.init(identifier: "zh-TW"))
    }
}


//struct SleepView_Previews: PreviewProvider {
//    static var previews: some View {
//        SleepView()
//    }
//}
