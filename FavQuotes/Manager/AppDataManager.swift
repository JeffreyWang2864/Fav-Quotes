//
//  AppDataManager.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import UIKit

class AppDataManager{
    public static let shared = AppDataManager()
    public var quotes: Array<Quote> = []
    
    private init(){
        //self.setupTestData()
    }
    
    private func setupTestData(){
        let q1 = Quote(author: "Francis Bacon", text: "Knowledge is power.")
        let q2 = Quote(author: "Hermann Meyer", text: "No enemy bomber can reach the Ruhr. If one reaches the Ruhr, my name is not Göring. You may call me Meyer")
        let q3 = Quote(author: "Donald J. Trump", text: "The beauty of me is that i'm very rich")
        self.quotes = [q1, q2, q3]
    }
    
    private func setupForFirstTime(){
        CoreDataManager.shared.saveObject(to: .Quote, with: ["Deng Xiaoping", "The colour of the cat doesn't matter as long as it catches the mice."])
        CoreDataManager.shared.saveObject(to: .Quote, with: ["Francis Bacon", "Knowledge is power."])
        CoreDataManager.shared.saveObject(to: .Quote, with: ["Karl Marx", "Surround yourself with people who make you happy. People who make you laugh, who help you when you’re in need. People who genuinely care. They are the ones worth keeping in your life. Everyone else is just passing through."])
        CoreDataManager.shared.saveObject(to: .Quote, with: ["Ruth Bader Ginsburg", "Fight for the things that you care about, but do it in a way that will lead others to join you."])
    }
    
    public func setupData(){
        if(Util.isAppFirstTimeLaunched()){
            self.setupForFirstTime()
        }
        let quotes = CoreDataManager.shared.fetchObject(with: .Quote) as! Array<QuoteEntity>
        for quote in quotes{
            let q = Quote(author: quote.author!, text: quote.quote!)
            AppDataManager.shared.quotes.append(q)
        }
    }
    
    public func syncQuotesWithCoreData(){
        let quotes = CoreDataManager.shared.fetchObject(with: .Quote) as! Array<QuoteEntity>
        for quote in quotes{
            CoreDataManager.shared.deleteObject(of: .Quote, with: quote)
        }
        for quote in self.quotes{
            CoreDataManager.shared.saveObject(to: .Quote, with: [quote.author, quote.quote])
        }
    }
}
