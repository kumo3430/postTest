//
//  IntervalView.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/25.
//

import SwiftUI

struct IntervalView: View {
    let targets = ["甜食","飲料"]
//    @Binding var target: String
    @Binding var targetQuantity: Int
    
//    @State var target: String
//    @State var targetQuantity: Int
    
    var body: some View {
        HStack {
            Text("我要睡滿")
            TextField("n", value: $targetQuantity, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
            Text("小時！！")
        }
    }
}

//struct IntervalView_Previews: PreviewProvider {
//    static var previews: some View {
//        IntervalView()
//    }
//}
