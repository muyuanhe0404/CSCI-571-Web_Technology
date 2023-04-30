//
//  AutoCompleteObject.swift
//  mobile_search
//
//  Created by HMY on 2023/4/22.
//

import UIKit

@MainActor
final class AutocompleteObject: ObservableObject {

    let delay: TimeInterval = 0.4

    @Published var suggestions: [String] = []

    init() {
    }

    private var task: Task<Void, Never>?

    func autocomplete(_ text: String, completion:@escaping ()->Void) {
        guard !text.isEmpty else {
            suggestions = []
            task?.cancel()
            return
        }

        task?.cancel()

        task = Task {
            await Task.sleep(UInt64(delay * 1_000_000_000.0))

            guard !Task.isCancelled else {
                return
            }
            
            APIHandler.sharedInstance.getSuggest(keywrod: text) { res in
                if let res = res?.embedded?.events {
                    self.suggestions = res.compactMap({ event in
                        return event.name
                    }).removeDuplicate()
                    completion()
                } else {
                    self.suggestions = []
                }
            }
        }
    }

    private func isSuggestion(in suggestions: [String], equalTo text: String) -> Bool {
        guard let suggestion = suggestions.first, suggestions.count == 1 else {
            return false
        }

        return suggestion.lowercased() == text.lowercased()
    }
}

public extension Array where Element: Equatable {
    
    func removeDuplicate() -> Array {
       return self.enumerated().filter { (index,value) -> Bool in
            return self.firstIndex(of: value) == index
        }.map { (_, value) in
            value
        }
    }
}
