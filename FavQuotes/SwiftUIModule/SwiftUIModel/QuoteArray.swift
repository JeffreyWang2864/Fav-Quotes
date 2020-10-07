//
//  QuoteArray.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/6/20.
//

import Foundation

class QuoteArray: ObservableObject{
    @Published var quotes: [Quote] = []
}
