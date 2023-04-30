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
    @StateObject var eventStore = EventStore()
    @ObservedObject private var autocomplete = AutocompleteObject()
    @State var keyword: String = ""
    @State var location: String = ""
    @State var isAuto: Bool = false
    @State var distance: Int = 10
    @State private var previewIndex = 0
    @State var searchResults: SearchResposne? = nil
    @State var isNavPush = false
    @State var loading = false
    @State private var showingSheet = false
    
    var previewOptions = ["Default", "Music", "Sports","Arts&Theatre","Film","Miscellaneous"]
    var segment = ["", "KZFzniwnSyZfZ7v7nJ", "KZFzniwnSyZfZ7v7nE","KZFzniwnSyZfZ7v7na","KZFzniwnSyZfZ7v7nn","KZFzniwnSyZfZ7v7n1"]
    
    var body: some View {
        NavigationView {
            
            Form {
                getHead()
                getView()
                if (isNavPush) {
                    NavigationLink(destination: FavouriteListView(eventStore: eventStore) ,isActive: $isNavPush) {EmptyView()}.hidden()
                }
                if searchResults != nil && loading == false{
                    Section("Result") {
                        if let events = searchResults?.embedded?.events, events.count > 0 {
                            getList(events: events)
                        } else {
                            Text("No result available").foregroundColor(.red)
                        }
                    }
                }
                if loading == true {
                    Section("Result") {
                        HStack {
                            Spacer()
                            ProgressView("loading").progressViewStyle(.circular)
                            Spacer()
                        }
                    }
                }
            }.navigationBarTitle("Event Search").navigationBarItems(trailing: Button(action: {
                isNavPush = true
            }, label: {
                Image(systemName: "heart.circle.fill")
            })).sheet(isPresented: $showingSheet) {
                AutoSuggestView(suggestions: autocomplete.suggestions.map({ str in
                    Suggestion(id: str, name: str)
                }), suggestKeyword: $keyword, showSheet: $showingSheet)
            }
        }
    }
    
    func getView() -> some View {
        HStack{
            Spacer()
            Button(action:{
                loading = true
                APIHandler.sharedInstance.eventSearch(keyword: keyword, address: location, category: segment[previewIndex], distance: distance, isAuto: isAuto) { resp in
                    loading = false
                    searchResults = resp
                }
            }){
                Text("Submit")
            }.disabled(keyword.isEmpty || (location.isEmpty && isAuto == false))
                .frame(width:70,height:20)
                .padding(.vertical,10)
                .padding(.horizontal,20)
                .background((keyword.isEmpty || (location.isEmpty && isAuto == false)) ? Color.gray : Color.red)
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
    }
    
    func getList(events: [Event]) -> some View {
        return List {
            ForEach(events) { result in
                NavigationLink(destination: DetailView(eventStore: eventStore, event: result)) {
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
    
    func getHead() -> some View {
        return Group {
            HStack{
                Text("Keyword:")
                Spacer()
                TextField("Keyword:", text: $keyword, prompt: Text("Required")).onSubmit {
                    autocomplete.autocomplete(keyword) {
                        if (!autocomplete.suggestions.isEmpty) {
                            showingSheet = true
                        }
                    }
                }
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
            if (!isAuto) {
                HStack{
                    Text("Location:")
                    Spacer()
                    TextField("Location:", text: $location,prompt: Text("Required"))
                }
            }
            Toggle(isOn: $isAuto) {
                Text("Auto-detect my location")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AutoSuggestView: View {
    @Environment(\.dismiss) var dismiss
    var suggestions: [Suggestion] = []
    @Binding var suggestKeyword: String
    @Binding var showSheet: Bool
    var body: some View {
        
        NavigationView {
            List {
                ForEach(suggestions) { suggest in
                    Text(suggest.name).onTapGesture {
                        suggestKeyword = suggest.name
                        
                        dismiss()
                        showSheet = false
                    }
                }
            }.navigationTitle("Suggestions")
        }
        
    }
}

struct Suggestion: Identifiable {
    let id: String
    let name: String
}
