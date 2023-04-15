//
//  SugarView.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/12.
//

import SwiftUI

struct SugarView: View {
    let targets = ["甜食","飲料"]
    @Binding var target: String
    @Binding var targetQuantity: Int
    
    var body: some View {
        HStack {
            Picker(selection: $target, label: Text("選擇大類別")) {
                ForEach(targets, id: \.self) { target in
                    Text(target)
                }
            }
            Text("少於")
            TextField("n", value: $targetQuantity, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
            Text("次 / 週 ")
        }
    }
}

//struct SugarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SugarView()
//    }
//}
