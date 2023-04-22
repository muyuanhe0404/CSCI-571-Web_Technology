//
//  ContentView.swift
//  search_app
//
//  Created by HMY on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Username", text: $username)
            }
            .navigationTitle("Setting")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
