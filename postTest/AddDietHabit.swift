//
//  AddDietHabit.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/25.
//

import SwiftUI

struct AddDietHabit: View {
    //    @ObservedObject var viewModel: SportWalkInsertViewModel
    //    @ObservedObject var viewModel: AddHabitClass
        @State var set_up_time: Date = Date()
    //    let classification = ["學習","運動","生活","作息"]
        @State var _classification: Int = 4
        let sub_classification = ["減糖"]
        @State var _sub_classification: Int = 0
        let Target = ["甜食","飲料"]
    //    @State var target: Int = 0
        @State var task_name: String = ""
        @State var tag_id1: Int = 0     //
        @State var quantity: Int = 0
        @State var begin: Date = Date()     //
        @State var finish: Date = Date()        //
        //@State var fulfill: Int = 0
        let cycle = ["日","週","月"]
//        @State var _cycle: Int = 0
        @State var note: String = ""
        @State var alert_time: Date = Date()
        //@State var show_to_club: String = ""
        //@State var completion: Int = 0
        @State var uid: Int = 0     //
        @State var Alert_time: String = ""
        @State var Set_up_time: String = ""
        
        
    //    @State var target: String = ""
        @State private var target_quantity: Int = 0
//        @State private var target_time: Date = Date()
//        @State private var Target_time: String = ""
        
        @State private var subClassification = 0
//        @State private var targetTime = Date()
    //    @State private var target = "Target 1"
        @State private var target = "甜食"
        @State private var target_number: Int = 0
        @State private var targetQuantity = 0

        
        @State private var chooseTag = false
        @Environment(\.dismiss) var dismiss
        
        func dateToDateString(_ date:Date) -> String {
            let timeZone = NSTimeZone.local
            let formatter = DateFormatter()
            formatter.timeZone = timeZone
            formatter.dateFormat = "yyyy-MM-dd  HH:mm:ss"
            let date = formatter.string(from: date)
            return date
        }
        
        var body: some View {
            NavigationStack {
                ScrollView {
                    VStack{
                        
                        Group {
                            HStack {
                            Text("類別：")
                                Picker(selection: $_sub_classification, label: Text("選擇大類別")) {
                                    ForEach(0 ..< sub_classification.count) {
                                        Text(sub_classification[$0]).tag($0)
                                    }
                                }
                            }
                            HStack {
                                Text("名稱：")
                                TextField("習慣名稱", text:$task_name)
                                    .textFieldStyle(.roundedBorder)
    //                                .keyboardType(.numberPad)
                                    .padding()
                            }
                            HStack {
    //                            Text("標籤：")
    //                            Button("選擇標籤") {
    //                                        chooseTag.toggle()
    //                                    }
    //                                    .sheet(isPresented: $chooseTag) {
    //                                        ChooseTag(viewModel: TagInsertViewModel())
    //                                    }
                            }
                            HStack {
                                        VStack {

                                            if _sub_classification == 0 {
                                                SugarView(target: $target,targetQuantity: $targetQuantity)
                                            }
                                        }
                            }
                            HStack {
                                Text("備注：")
                                // 將帳號密碼的資料存放到LoginInsertViewModel的password
                                TextField("備注", text:$note)
                                    .textFieldStyle(.roundedBorder)
    //                                .keyboardType(.numberPad)
                                    .padding()
                            }
                            HStack {
                                DatePicker("提醒時間：", selection: $alert_time,displayedComponents: .hourAndMinute)
                                    .environment(\.locale, Locale.init(identifier: "zh-TW"))
                                
                            }
    //                        HStack {
    //                            Text("分享社群：")
    //                        }
                        }
                        .padding(12)
                        .background(Color.white)
                        
                        Button{
    //                        Begin = dateToDateString(begin)
    //                        Finish = dateToDateString(finish)
                            dateToDateString()
                            Alert_time = alertToDateString(alert_time)
//                            Target_time = alertToDateString(target_time)
    //                        alertToDateString()
                            Set_up_time = setToDateString(set_up_time)
    //                        setToDateString()
                            newSportHabit()
                            dismiss()
    //                        print(123)
    //                        print(target)
    //                        print($target)
    //                        print(targetQuantity)
    //                        print($targetQuantity)
                        } label: {
                            HStack{
                                Spacer()
    //                            NavigationLink(destination: livesView()) {
    //                                Text("完成")
    //                                    .foregroundColor(.white)
    //                                    .padding(.vertical, 10)
    //                                    .font(.system(size: 14,weight: .semibold))()
    //                            }
                                
                                Text("完成")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 14,weight: .semibold))
                                Spacer()
                            }.background(Color.blue)
                        }
                    }
                    .navigationTitle("建立飲食習慣")
                }
                
            }
        }
        
        private func sleep() {
    //        let target = "NULL"
    //        let target_quantity = "NULL"
        }
        private func sugar() {
    //        target_time = "NULL"
        }
        
        private func dateToDateString() {
            let timeZone = NSTimeZone.local
            let formatter = DateFormatter()
            formatter.timeZone = timeZone
            formatter.dateFormat = "yyyy-MM-dd"
    //        Begin = formatter.string(from: begin)
    //        Finish = formatter.string(from: finish)
    //        print(Begin)
    //        print(Finish)
    //        return date
        }
        
        private func alertToDateString(_ date: Date) -> String {
            let timeZone = NSTimeZone.local
            let formatter = DateFormatter()
            formatter.timeZone = timeZone
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: date)
            print(dateString)
            return dateString
        }
        private func setToDateString(_ date: Date) -> String {
            let timeZone = NSTimeZone.local
            let formatter = DateFormatter()
            formatter.timeZone = timeZone
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: date)
            print(dateString)
            return dateString
        }

        
        private func newSportHabit() {

            let url = URL(string: "http://127.0.0.1:8888/addHabits/AddDietHabit.php")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            if (target == "甜食"){
                target_number = 0
            } else if (target == "飲料") {
                target_number = 1
            }
            print(target_number)
            let body : [String: Any] = ["_classification":_classification,"set_up_time": Set_up_time,"_sub_classification": _sub_classification,"task_name": task_name,"tag_id1": tag_id1,"target": target_number,"target_quantity": targetQuantity,"note": note,"alert_time": Alert_time]
            print(body)
            let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { data, response, error in
                // handle response
                if let data,
                  let content = String(data: data, encoding: .utf8) {
                   print(content)
                }
                guard let data = data else { return }
    //            print(String(data: data, encoding: .utf8)!)
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String else { return }
                    if status == "success" {
    //                    self.isLoggedIn = true
                    } else {
                        print("Registration failed")
                    }
                } catch {
    //                print(error.localizedDescription)
                    print(String(describing: error))
                }
            }.resume()
        }
}

struct AddDietHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddDietHabit()
    }
}
