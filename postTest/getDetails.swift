//
//  getDetails.swift
//  postTest
//
//  Created by 呂沄 on 2023/4/6.
//

import SwiftUI

struct getDetails: View {
    var body: some View {
        NavigationStack {
            
        }.navigationTitle("運動")
            .onAppear {
                self.GetDetails()
            }
    }
    private func GetDetails() {
        
    }
}

struct getDetails_Previews: PreviewProvider {
    static var previews: some View {
        getDetails()
    }
}
