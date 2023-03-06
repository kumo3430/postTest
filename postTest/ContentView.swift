//
//  ContentView.swift
//  postTest
//
//  Created by 呂沄 on 2023/3/6.
//

import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            TextField("Email", text: $email)
            Button(action: {
                registerUser()
            }, label: {
                Text("Register")
            })
        }
    }
    
    func registerUser() {
        let userData = ["username": username, "password": password, "email": email]
        guard let url = URL(string: "http://your-api-url.com/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: userData, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle response
        }.resume()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
