//
//  Sleep.swift
//  postTest
//
//  Created by 呂沄 on 2023/5/12.
//

import SwiftUI

struct Sleep: View {
    var body: some View {
        VStack {
                   Text("我要睡了")
                       .font(.title)
                       .padding()
                   
                   Button(action: {
                       // 按钮点击事件
                   }) {
                       Text("关闭")
                           .foregroundColor(.white)
                           .padding()
                           .background(Color.blue)
                           .cornerRadius(10)
                   }
                   .padding()
               }    }
}

struct Sleep_Previews: PreviewProvider {
    static var previews: some View {
        Sleep()
    }
}
