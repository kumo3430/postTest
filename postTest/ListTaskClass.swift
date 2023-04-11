//
//  ListTaskClass.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/11.
//

import SwiftUI

struct ListTaskClass: View {
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink("學習") {
                    AddHabitClass()
                }
                NavigationLink("運動") {
                    SportListView()
                }
            }
            .navigationTitle("顯示習慣類別")
        }
    }
}

struct ListTaskClass_Previews: PreviewProvider {
    static var previews: some View {
        ListTaskClass()
    }
}
