//
//  Quote.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import Foundation

class Quote{
    public var author: String
    public var quote: String
    init(author: String = "", text: String = ""){
        self.author = author
        self.quote = text
    }
    
    var isEmpty: Bool{
        get{
            return self.author.isEmpty && self.quote.isEmpty
        }
    }
}

func ==(left: Quote, right: Quote) -> Bool{
    return left.author == right.author && left.quote == right.quote
}
