//
//  list02.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/4.
//

import SwiftUI


struct list02: View {
    @State var taskNames: [String] = []

    var body: some View {
        VStack {
            ForEach(taskNames, id: \.self) { taskName in
                Text(taskName)
            }
        }
        .onAppear() {
            let jsonString = """
                ["Uiii","Refer","Look","","Hi"]
            """
            let jsonData = jsonString.data(using: .utf8)!
            do {
                let decoder = JSONDecoder()
                let taskNames = try decoder.decode([String].self, from: jsonData)
                self.taskNames = taskNames
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


struct list02_Previews: PreviewProvider {
    static var previews: some View {
        list02()
    }
}
