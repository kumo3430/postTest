import SwiftUI

struct login4: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var errorMessage = ""
    @State private var getUsername = ""
    @State private var errorEmpty = ""
    
    struct UserData : Decodable {
        var id: String
        var username: String
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    Text("You are logged in!")
                    Text(getUsername)
                    NavigationLink {
                        AddHabitClass()
                    } label: {
                        Text("建立習慣")
                    }
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
                    Text(errorEmpty)
                        .foregroundColor(.red)
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
    }
    
    private func register() {
        guard !username.isEmpty && !password.isEmpty else {
            print("Please fill in all required fields.")
            errorEmpty = "請確認帳號密碼都有輸入"
            return
        }
        errorEmpty = ""
        errorMessage = ""
        let url = URL(string: "http://127.0.0.1:8888/register/register3.php")!
        var request = URLRequest(url: url)
//        print(url)
//        print(request)
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
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let dict = jsonResponse as? [String: Any], let status = dict["status"] as? String else { return }
                if status == "success" {
                    self.isLoggedIn = true
                } else {
                    print("Registration failed")
                }
            } catch {
//                print(error.localizedDescription)
                print(String(describing: error))
            }
        }.resume()
    }
    
    private func login() {
        guard !username.isEmpty && !password.isEmpty else {
            print("Please fill in all required fields.")
            errorEmpty = "請確認帳號密碼都有輸入"
            return
        }
        errorEmpty = ""
        errorMessage = ""
        let url = URL(string: "http://127.0.0.1:8888/login/login3.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["username": username, "password": password]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("No data returned from server.")
                return
            }
            if let content = String(data: data, encoding: .utf8) {
                print(content)
            }
//            if let data,
//              let content = String(data: data, encoding: .utf8) {
//               print(content)
//            }
            if let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode != 200 {
                print("httpResponse.statusCode: \(httpResponse.statusCode)")
                errorMessage = "帳號或密碼輸入錯誤"
            } else {
                let decoder = JSONDecoder()
                do {
                    let userData = try decoder.decode(UserData.self, from: data)
                    print("============== userData ==============")
                    print(userData)
                    print("使用者名稱為：\(userData.username)")
                    getUsername = userData.username
                    print("============== userData ==============")
                } catch {
                    print("解碼失敗：\(error)")
                }

//                if let userData = try? decoder.decode(UserData.self, from: data) {
//                    print("============== userData ==============")
//                    print(userData)
//                    print("使用者名稱為：\(userData.username)")
//                    print("============== userData ==============")
//               }
                isLoggedIn = true
                print(isLoggedIn)
            }
        }.resume()
    }
    
    private func logout() {
        isLoggedIn = false
//        let url = URL(string: "http://10.1.1.31:8888/login/logout.php")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // handle response
//            isLoggedIn = false
//        }.resume()
    }
}

struct login4_Previews: PreviewProvider {
    static var previews: some View {
        login4()
    }
}
