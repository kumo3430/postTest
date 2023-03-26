//
//  ContentView.swift
//  postTest
//
//  Created by 呂沄 on 2023/3/6.
//

import SwiftUI

struct loginAi: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""

    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                VStack{
                    Group {
                        // 將帳號密碼的資料存放到LoginInsertViewModel的eamil
                        TextField("Username", text: $username)
                            .padding(.horizontal, 16)
                            .frame(height: 44)
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        TextField("Email", text: $email)
                            .padding(.horizontal, 16)
                            .frame(height: 44)
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        // 將帳號密碼的資料存放到LoginInsertViewModel的password
                        SecureField("Password", text: $password)
                            .padding(.horizontal, 16)
                            .frame(height: 44)
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                    }
                    .padding(12)
                    .background(Color.white)
                    Button(action: {
                        registerUser()
                    }, label: {
                        Text("Register")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                    })
                }
                .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .background(Color.white)
        }
    }

    func registerUser() {
        guard !username.isEmpty && !password.isEmpty && !email.isEmpty else {
            print("Please fill in all required fields.")
            return
        }
        let userData = ["username": username, "password": password, "email": email]

        guard let url = URL(string: "http://localhost:8888/login/insert.php") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: userData, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let content = String(data: data, encoding: .utf8) {
                print(content)
            }
        }.resume()
    }
}

struct loginAi_Previews: PreviewProvider {
    static var previews: some View {
        loginAi()
    }
}
