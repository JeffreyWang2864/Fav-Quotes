//
//  QuoteEntity+CoreDataProperties.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//
//

import Foundation
import CoreData


extension QuoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteEntity> {
        return NSFetchRequest<QuoteEntity>(entityName: "QuoteEntity")
    }

    @NSManaged public var quote: String?
    @NSManaged public var author: String?

}
