//
//  AddHabitClass.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddHabitClass: View {
    
    @State private var showingSheet = false
    @State private var ShowingSheet = false

    var body: some View {
        
        NavigationStack {
//            ScrollView {
                VStack{
                    
                        Button("運動") {
                                  showingSheet.toggle()
                              }
                              .sheet(isPresented: $showingSheet) {
                                  AddSportWalk()
                              }
                        Button("作息") {
                                  ShowingSheet.toggle()
                              }
                              .sheet(isPresented: $ShowingSheet) {
                                  AddRoutineHabit()
                              }
                }
//            }
            .navigationTitle("習慣建立")
        }
        }
}

struct AddHabitClass_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitClass()
    }
}
