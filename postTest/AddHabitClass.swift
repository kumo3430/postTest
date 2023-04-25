//
//  AddHabitClass.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddHabitClass: View {
    
    @State private var showingSheetSport = false
    @State private var showingSheetRoutine = false
    @State private var showingSheetDiet = false

    var body: some View {
        
        NavigationStack {
//            ScrollView {
                VStack{
                    Button("運動") {
                        showingSheetSport.toggle()
                          }
                          .sheet(isPresented: $showingSheetSport) {
                              AddSportWalk()
                          }
                    Button("作息") {
                        showingSheetRoutine.toggle()
                          }
                          .sheet(isPresented: $showingSheetRoutine) {
                              AddRoutineHabit()
                          }
                    Button("飲食") {
                        showingSheetDiet.toggle()
                          }
                          .sheet(isPresented: $showingSheetDiet) {
                              AddDietHabit()
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
