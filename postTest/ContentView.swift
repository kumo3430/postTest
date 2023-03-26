//
//  ContentView.swift
//  postTest
//
//  Created by 呂沄 on 2023/3/6.
//請用繁體中文詳細告訴我該如何操作以下步驟“在 Swift 專案中，使用swiftui創建一個註冊視圖控制器，該控制器包含用戶需要輸入的資訊，如用戶名稱、密碼、電子郵件等等。
//實現 Swift 代碼，使用戶在填寫完所有必填項目後，點擊“註冊”按鈕時，將用戶輸入的資料打包成一個 HTTP 請求，發送到您創建的後端 API。”

import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Group{
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                }
                
                Button(action: {
                    registerUser()
                }, label: {
                    Text("Register")
                })
            }
        }
    }
    
    func registerUser() {
        guard !username.isEmpty && !password.isEmpty && !email.isEmpty else {
            print("Please fill in all required fields.")
            return
        }
        let userData = ["username": username, "password": password, "email": email]
//        let userData = """
//        {
//        "username":\(username),
//        "password":\(password),
//        "email":\(email)
//        }
//        """
//        guard let url = URL(string: "http://localhost:8888/login/insert.php?username=\(username)&password=\(password)&email=\(email)") else { return }
        
        guard let url = URL(string: "http://localhost:8888/register/register.php") else { return }


        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: userData, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data,
              let content = String(data: data, encoding: .utf8) {
               print(content)
            }            // handle response
        }.resume()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
