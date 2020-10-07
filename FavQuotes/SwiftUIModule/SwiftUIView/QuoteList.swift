//
//  QuoteList.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/6/20.
//

import SwiftUI

struct QuoteList: View {
    @ObservedObject var appState = AppState()
    @State private var selectedQuote: Quote?
    @State private var showNewQuote: Bool = false
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            header
            list
            Spacer()
            Divider()
            toolbar
        }
        .background(
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
        )
        
    }
    
    var list: some View {
        List {
            ForEach(appState.quotes) { quote in
                VStack(alignment: .leading) {
                    Text(quote.quote)
                        .padding(.vertical)
                    HStack {
                        Spacer()
                        Text("--- " + quote.author)
                            .bold()
                            .padding([.trailing, .bottom])
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedQuote = quote
                }
            }.onDelete(perform: self.appState.deleteQuotes)
            
        }.listStyle(InsetGroupedListStyle())
        .sheet(item: $selectedQuote) { quote in
            QuoteEditor(quote: quote)
        }
    }
    
    var header: some View {
        HStack(spacing: 15) {
            Image(systemName: "bookmark.fill")
                .font(.system(size: 33))
                .foregroundColor(.red)
            Text("Fav Quotes")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.black)
        }.padding(.horizontal, 20)
        .padding(.top)
    }
    
    var toolbar: some View {
        HStack {
            Spacer()
            Text("\(appState.quotes.count) quotes")
                .font(.caption)
            Spacer()
            Button(action: {
                self.appState.quotes.append(Quote())
                showNewQuote = true
            }) {
                Image(systemName: "plus.circle")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showNewQuote) { () -> QuoteEditor in
            return QuoteEditor(quote: self.appState.quotes.last!)
        }
    }
}

struct QuoteList_Previews: PreviewProvider {
    static var previews: some View {
        QuoteList()
    }
}
