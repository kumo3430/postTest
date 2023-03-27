//import SwiftUI
//
//struct login4: View {
////    var UserData: Dictionary<String, String>
////    struct UserData {
////        var username: String
////        var password: String
//////        @State private var username = ""
//////        @State private var password = ""
////    }
//
//    @State private var username = ""
//    @State private var password = ""
//    @State private var isLoggedIn = false
//    
//    var body: some View {
//        VStack {
//            if isLoggedIn {
//                Text("You are logged in!")
//                Button("Log out") {
//                    logout()
//                }
//            } else {
//                TextField("Username", text: $username)
//                SecureField("Password", text: $password)
//                Button("Register") {
//                    register()
//                }
//                Button("Log in") {
//                    login()
//                }
//            }
//        }
//        .padding()
//    }
//    
//    private func register() {
////        guard !username.isEmpty && !password.isEmpty else {
////            print("Please fill in all required fields.")
////            return
////        }
////        let url = URL(string: "http://10.1.1.31:8888/register/register2.php")
//        let url = URL(string: "http://10.1.1.31:8888/register/register2")
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-type")
//        let encoder = JSONEncoder()
////        let body = ["username": username, "password": password]
//        let post_body = UserData(username: username, password: password)
//        let data = try? encoder.encode(post_body)
//        request.httpBody = data
////        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
////        request.httpBody = jsonData
////        URLSession.shared.dataTask(with: request) { data, response, error in
////            // handle response
////            if let data,
////              let content = String(data: data, encoding: .utf8) {
////               print(content)
////            }
//        Task {
//            do {
//                let sessionConfig = URLSessionConfiguration.default
//                sessionConfig.timeoutIntervalForRequest=3
//                let (data, resp) = try await URLSession.shared.data(for: request)
//                // https://stackoverflow.com/a/70307854
//                print (resp)
//                if let httpResponse = resp as? HTTPURLResponse, httpResponse.statusCode != 200 {
//                    print ("httpResponse.statusCode: (httpResponse.statusCode)")
//                } else { // status code == 200
//                    let decoder = JSONDecoder ( )
//                    response = try decoder.decode (PostResponse.self, from: data)
//                    showPreviewView = true
//                }
//            }catch {
//                print(error)
//                showAlertView = true
//            }
//        }.resume()
//    }
//    
//    private func login() {
////        guard !username.isEmpty && !password.isEmpty else {
////            print("Please fill in all required fields.")
////            return
////        }
//        let url = URL(string: "http://10.1.1.31:8888/login/login2.php")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let body = ["username": username, "password": password]
//        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
//        request.httpBody = jsonData
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data,
//              let content = String(data: data, encoding: .utf8) {
//               print(content)
//            }
//            // handle response
//            if let httpResponse = response as? HTTPURLResponse,
//               httpResponse.statusCode == 200 {
//                isLoggedIn = true
//            }
//        }.resume()
//    }
//    
//    private func logout() {
//        let url = URL(string: "http://10.1.1.31:8888/login/logout.php")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // handle response
//            isLoggedIn = false
//        }.resume()
//    }
//}
//
//struct login4_Previews: PreviewProvider {
//    static var previews: some View {
//        login4()
//    }
//}
