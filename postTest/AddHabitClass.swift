//
//  AddHabitClass.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddHabitClass: View {
    var body: some View {
        
        NavigationStack {
            VStack{
                NavigationLink("學習") {
//                    AddStudyGeneral()
                }
                NavigationLink("運動") {
//                    AddSportWalk(viewModel: SportWalkInsertViewModel())
                    AddSportWalk()
                }
            }
            .navigationTitle("習慣建立")
        }
        
    }
}

struct AddHabitClass_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitClass()
    }
}
