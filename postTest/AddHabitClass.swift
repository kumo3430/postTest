//
//  AddHabitClass.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddHabitClass: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        
        NavigationStack {
//            VStack{
//                NavigationLink("學習") {
////                    AddStudyGeneral()
//                }
//                NavigationLink("運動") {
////                    AddSportWalk(viewModel: SportWalkInsertViewModel())
//                    AddSportWalk()
//                }
//            }
//            @State private var showingSheet = false
            Button("運動") {
                      showingSheet.toggle()
                  }
                  .sheet(isPresented: $showingSheet) {
                      AddSportWalk()
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
