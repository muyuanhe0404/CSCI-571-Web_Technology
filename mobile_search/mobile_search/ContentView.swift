//
//  ContentView.swift
//  mobile_search
//
//  Created by HMY on 4/11/23.
//

import SwiftUI
import Alamofire
import Kingfisher
struct ContentView: View {
    @State var keyword: String = ""
    @State var location: String = ""
    @State var isAuto: Bool = false
    @State var distance: Int = 10
    @State private var previewIndex = 0
    @State var searchResults: SearchResposne? = nil
    var previewOptions = ["Default", "Music", "Sports","Arts&Theatre","Film","Miscellaneous"]
    
    var body: some View {
        NavigationView {
            Form {
                HStack{
                    Text("Keyword:")
                    Spacer()
                    TextField("Keyword:", text: $keyword, prompt: Text("Required"))
                }
                HStack{
                    Text("Distance:")
                    Spacer()
                    TextField("Distance:", value: $distance, format: .number)
                }
                Picker(selection: $previewIndex, label: Text("Catagory:")) {
                    ForEach(0 ..< previewOptions.count) {
                        Text(self.previewOptions[$0])
                    }
                }
                HStack{
                    Text("Location:")
                    Spacer()
                    TextField("Location:", text: $location,prompt: Text("Required"))
                }
                Toggle(isOn: $isAuto) {
                    Text("Auto-detect my location")
                }
                HStack{
                    Spacer()
                    Button(action:{
                        print("search")
                        print(keyword)
                        print(distance)
                        print(previewOptions[previewIndex])
                        print(location)
                        print(isAuto)
                        APIHandler.sharedInstance.eventSearch(keyword: keyword) { resp in
                            searchResults = resp
                        }
                    }){
                        Text("Submit")
                    }
                    .frame(width:70,height:20)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .buttonStyle(BorderlessButtonStyle())
                    
                    
                    Button(action:{
                        print("clear")
                        keyword=""
                        distance=10
                        previewIndex = 0
                        location=""
                        isAuto = false
                    }){
                        Text("Clear")
                    }
                    .frame(width:70,height:20)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .buttonStyle(BorderlessButtonStyle())
                    Spacer()
                }
                
                Section("Result") {
                    List {
                        ForEach(searchResults?.embedded?.events ?? []) { result in
                            NavigationLink(destination: DetailView(event: result)) {
                                HStack{
                                    Text(result.dates?.start?.dateTime ?? "")
                                        .font(.system(size: 11))
                                        .foregroundColor(Color.gray)
                                        .padding(.trailing)
                                    KFImage(URL(string: result.images?.first?.url ?? "")!).resizable()
                                        .padding(.trailing)
                                        .scaledToFill().frame(width: 30, height:30)
                                    Text(result.name ?? "").font(.system(size: 11)).padding(.trailing)
                                    Text(result.embedded?.venues?.first?.name ?? "").font(.system(size: 11))
                                        .foregroundColor(Color.gray)
                                }.frame(height: 80)
                            }
                        }
                    }
                }
            }.navigationBarTitle("Event Search")
        }
        
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
