//
//  login.swift
//  postTest
//
//  Created by 呂沄 on 2023/3/16.
//

import SwiftUI

struct login: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            if isLoggedIn {
                Text("Welcome, \(username)!")
                Button("Logout") {
                    // Call the logout API here to log the user out
                    isLoggedIn = false
                    username = ""
                    password = ""
                }
            } else {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Login") {
                    Task {
                        do {
                            let response = try await login(username: username, password: password)
                            isLoggedIn = true
                            alertMessage = ""
                        } catch {
                            alertMessage = error.localizedDescription
                        }
                    }
                }
                .alert(isPresented: Binding(get: { alertMessage != "" }, set: { _ in })) {
                    Alert(title: Text("Error"), message: Text(alertMessage))
                }
            }
        }
        .padding()
    }
    
    private func login(username: String, password: String) async throws -> String {
        // Call the login API here to authenticate the user
        // You can use URLSession to send HTTP requests
        // For example:
        let url = URL(string: "http://localhost:8888/login/login.php?username=\(username)&password=\(password)&email=\(email)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["username": username, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = String(data: data, encoding: .utf8)!
        return response
    }
//
//    func login(username: String, password: String) async throws -> String {
//            let url = URL(string: "http://localhost:8888/login/login2.php?username=\(username)&password=\(password)&email=\(email)")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            let body = "username=\(username)&password=\(password)"
//            request.httpBody = body.data(using: .utf8)
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data else {
//                    print("無法獲取資料：\(error?.localizedDescription ?? "未知錯誤")")
//                    return
//                }
//
//                if let responseString = String(data: data, encoding: .utf8), responseString.contains("登錄成功") {
//                    DispatchQueue.main.async {
//                        self.isLoggedIn = true
//                    }
//                }
//            }.resume()
//        }
//
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}

