//
//  EventsView.swift
//  mobile_search
//
//  Created by HMY on 2023/4/17.
//

import SwiftUI
import Kingfisher

struct EventsView: View {
    var body: some View {
        VStack() {
            Text("title")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack {
                Text("Date")
                    .font(.title3)
                Spacer()
                Text("Artisit/Team")
                    .font(.title3)
            }
            HStack {
                Text("Date")
                    .foregroundColor(Color.gray)
                Spacer()
                Text("Artisit/Team")
                    .foregroundColor(Color.gray)
            }
            .padding(.bottom)
            HStack {
                Text("Venue")
                    .font(.title3)
                Spacer()
                Text("Artisit/Team")
                    .font(.title3)
            }
            HStack {
                Text("Date")
                    .foregroundColor(Color.gray)
                Spacer()
                Text("Artisit/Team")
                    .foregroundColor(Color.gray)
            }
            .padding(.bottom)
            HStack {
                Text("Price Range")
                    .font(.title3)
                Spacer()
                Text("Ticket Status")
                    .font(.title3)
            }
            HStack {
                Text("Date")
                    .foregroundColor(Color.gray)
                Spacer()
                Button("Onsale", action: {}).frame(width: 120.0, height: 30.0).background(Color.green).foregroundColor(Color.white).cornerRadius(8)
            }
            Button("Save Event", action: {
                
            }).frame(width: 150, height: 40).background(Color.blue).foregroundColor(Color.white).cornerRadius(8)
            KFImage(URL(string: "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png")!)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
