import SwiftUI

struct login3: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack {
            if isLoggedIn {
                Text("You are logged in!")
                Button("Log out") {
                    logout()
                }
            } else {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
                Button("Register") {
                    register()
                }
                Button("Log in") {
                    login()
                }
            }
        }
        .padding()
    }
    
    private func register() {
//        guard !username.isEmpty && !password.isEmpty else {
//            print("Please fill in all required fields.")
//            return
//        }
        let url = URL(string: "http://127.0.0.1:8888/register/register3.php")!
        var request = URLRequest(url: url)
        print(url)
        print(request)
        request.httpMethod = "POST"
        let body = ["username": username, "password": password]
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle response
            if let data,
              let content = String(data: data, encoding: .utf8) {
               print(content)
            }
            print(response)
            print(error)
        }.resume()
    }
    
    private func login() {
//        guard !username.isEmpty && !password.isEmpty else {
//            print("Please fill in all required fields.")
//            return
//        }
        let url = URL(string: "http://10.1.1.31:8888/login/login2.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["username": username, "password": password]
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data,
              let content = String(data: data, encoding: .utf8) {
               print(content)
            }
            // handle response
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                isLoggedIn = true
            }
        }.resume()
    }
    
    private func logout() {
        let url = URL(string: "http://10.1.1.31:8888/login/logout.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle response
            isLoggedIn = false
        }.resume()
    }
}

struct login3_Previews: PreviewProvider {
    static var previews: some View {
        login3()
    }
}
