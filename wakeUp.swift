//
//  wakeUp.swift
//  postTest
//
//  Created by 呂沄 on 2023/5/15.
//

import SwiftUI

struct wakeUp: View {
    @State var set_date: Date = Date()
    @State var Set_date: String = ""
    
    @State var set_time: Date = Date()
    @State var Set_time: String = ""
    
    @State var set_up_time: Date = Date()
    @State var Set_up_time: String = ""
    
    @State private var showOtherView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Button(action: {
                    self.setTime()
                    newSportHabit()
                    print("我醒來了")
                }) {
                    HStack {
                        Text("我醒來了")
                            .fontWeight(.semibold)
                            .font(.title)
                        Image(systemName: "sunrise.circle.fill")
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                }
                Spacer()
                Button(action: {
//                    routineList()
                    showOtherView = true
                }) {
                    HStack {
                        Text("查看紀錄")
                            .fontWeight(.semibold)
                            .font(.title)
                        Image(systemName: "doc.plaintext")
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                }
                .sheet(isPresented: $showOtherView) {
                    routineList()
                }
                Spacer()
                VStack(alignment:.leading) {
                    HStack {
                        Text("連續天數：")
                    }
                    .padding()
                    .foregroundColor(.red)
                    HStack {
                        Text("今日日期：")
                        Text(Date(), style: .date)
                    }
                    .padding()
                    HStack {
                        Text("當下時間：")
                        Text(Date(), style: .time)
                    }
                    .padding()
                }
                .frame(alignment: .trailing)
                .fontWeight(.bold)
                .font(.title)
                .padding()
                Spacer()
                Spacer()
            }
            .navigationTitle("我醒來了")
        }
        .onAppear{
            
        }
    }
    private func setTime() {
        Set_date = dateToDateString(set_date)
        Set_time = alertToDateString(set_time)
        Set_up_time = setToDateString(set_up_time)
    }
    
    private func dateToDateString(_ date: Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        print(dateString)
        return dateString
    }
    
    private func alertToDateString(_ date: Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
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
        let url = URL(string: "http://127.0.0.1:8888/addHabits/WakeUp.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body : [String: Any] = ["set_date": Set_date,"set_time": Set_time,"set_up_time": Set_up_time]
//        print(body)
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

struct wakeUp_Previews: PreviewProvider {
    static var previews: some View {
        wakeUp()
    }
}
