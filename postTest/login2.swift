//
//  login2.swift
//  postTest
//
//  Created by 呂沄 on 2023/3/16.
//

import SwiftUI

struct login2: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    
    func register() {
        let parameters = ["username": username, "password": password, "email": email]
        guard let url = URL(string: "http://localhost:8888/login/insert.php?username=\(username)&password=\(password)&email=\(email)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String else { return }
                if status == "success" {
                    self.isLoggedIn = true
                } else {
                    print("Registration failed")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func login() {
        let parameters = ["username": username, "password": password]
        guard let url = URL(string: "http://localhost:8888/login/login.php?username=\(username)&password=\(password)&email=\(email)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String else { return }
                if status == "success" {
                    self.isLoggedIn = true
                } else {
                    print("Login failed")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func logout() {
        guard let url = URL(string: "https://yourapi.com/logout.php") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.isLoggedIn = false
        }.resume()
    }
    
    var body: some View {
        VStack {
            if isLoggedIn {
                Text("Welcome, \(username)")
                Button(action: logout) {
                    Text("Logout")
                }
            } else {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: register) {
                    Text("Register")
                }
                Button(action: login) {
                    Text("Login")
                }
            }
        }
    }
}

struct login2_Previews: PreviewProvider {
    static var previews: some View {
        login2()
    }
}
