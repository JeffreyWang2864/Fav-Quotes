//
//  QuoteEditor.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/6/20.
//

import SwiftUI

struct QuoteEditor: View {
    var quote: Quote
    
    var body: some View {
        VStack {
            TextEditor(text: .init(get: { quote.quote }, set: { quote.quote = $0 }))
                .foregroundColor(.white)
                .font(.system(size: 28, weight: .bold, design: .default))
                .padding()
                .background(Color(FQColor.themeColor).edgesIgnoringSafeArea(.all))
                .overlay(Image("bookmark-white"), alignment: Alignment(horizontal: .trailing, vertical: .top))
                
            TextEditor(text: .init(get: { quote.author }, set: { quote.author = $0 }))
                .font(.system(size: 28, weight: .bold, design: .default))
                .padding()
                
        }
    }
    
    init(quote: Quote) {
        self.quote = quote
        UITextView.appearance().backgroundColor = .clear
    }
}

struct QuoteEditor_Previews: PreviewProvider {
    static var previews: some View {
        QuoteEditor(quote: AppDataManager.shared.quotes[0])
    }
}
