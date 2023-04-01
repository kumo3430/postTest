//
//  AddSportWalk.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddSportWalk: View {
    
//    @ObservedObject var viewModel: SportWalkInsertViewModel
    
    @State var set_up_time: Date = Date()
    
//    let classification = ["學習","運動","生活","作息"]
//    @State var _classification = 0
    let sub_classification = ["健走","跑步","游泳","騎車"]
    @State var _sub_classification: Int = 0
    @State var task_name: String = ""
    @State var tag_id1: Int = 0     //
    @State var quantity: Int = 0
    @State var begin: Date = Date()     //
    @State var finish: Date = Date()        //
    //@State var fulfill: Int = 0
    let cycle = ["日","週","月"]
    @State var _cycle: Int = 0
    @State var note: String = ""
    @State var alert_time: Date = Date()
    //@State var show_to_club: String = ""
    //@State var completion: Int = 0
    @State var uid: Int = 0     //
    @State var Begin: String = ""
    @State var Finish: String = ""
    @State var Alert_time: String = ""
    @State var Set_up_time: String = ""
    
    @State private var chooseTag = false
    
    
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
                        // 將帳號密碼的資料存放到LoginInsertViewModel的eamil
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
                            DatePicker("開始日期：", selection: $begin,displayedComponents: .date)
                                .environment(\.locale, Locale.init(identifier: "zh-TW"))

                        }
                        HStack {
                            DatePicker("結束日期：", selection: $finish,displayedComponents: .date)
                                .environment(\.locale, Locale.init(identifier: "zh-TW"))

                        }
                        HStack {
                            Text("目標：")
                            TextField("km", value:$quantity, format: .number)
                                .textFieldStyle(.roundedBorder)
//                                .keyboardType(.numberPad)
                                .padding()
                            Text("Km    /")
                            Picker(selection: $_cycle) {
                                Text(cycle[0]).tag(0)
                                Text(cycle[1]).tag(1)
                                Text(cycle[2]).tag(2)
                            } label: {
                                Text("選擇大類別")
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
                        Begin = dateToDateString(begin)
                        Finish = dateToDateString(finish)
                        dateToDateString()
                        Alert_time = alertToDateString(alert_time)
//                        alertToDateString()
                        Set_up_time = setToDateString(set_up_time)
//                        setToDateString()
                        newSportHabit()
                        print(123)
                    } label: {
                        HStack{
                            Spacer()
                            Text("完成")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14,weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                }
                .navigationTitle("運動")
            }
            
        }
    }
    
    private func dateToDateString() {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        Begin = formatter.string(from: begin)
        Finish = formatter.string(from: finish)
        print(Begin)
        print(Finish)
//        return date
    }
    
    private func alertToDateString(_ date: Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd"
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

        let url = URL(string: "http://127.0.0.1:8888/addHabits/addSports.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body : [String: Any] = ["set_up_time": Set_up_time,"_sub_classification": _sub_classification,"task_name": task_name,"tag_id1": tag_id1,"quantity": quantity,"begin": Begin,"finish": Finish,"_cycle": _cycle,"note": note,"alert_time": Alert_time]
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
            print(String(data: data, encoding: .utf8)!)
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

struct AddSportWalk_Previews: PreviewProvider {
    static var previews: some View {
        AddSportWalk()
    }
}
