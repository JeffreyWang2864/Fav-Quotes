//
//  AppState.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/6/20.
//

import Combine
import Foundation

class AppState: ObservableObject {
    
    @Published var quotes: [Quote] = [] {
        didSet {
            AppDataManager.shared.quotes = self.quotes
        }
    }
    
    func deleteQuotes(at offsets: IndexSet) {
        quotes.remove(atOffsets: offsets)
    }
    
    init() {
        self.quotes = AppDataManager.shared.quotes
    }
}

extension Quote: Identifiable {
  var id: UUID {
    UUID()
  }
}
