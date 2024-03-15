//
//  Memo+CoreDataProperties.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/15/24.
//
//

import Foundation
import CoreData

extension Memo {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }
    
    @NSManaged public var contents: String?
    @NSManaged public var date: Date?
    
    var dateString: String? {
        guard let date = self.date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

extension Memo : Identifiable {
    
}
