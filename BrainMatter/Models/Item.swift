//
//  Item.swift
//  BrainMatter
//
//  Created by Joseph DeWeese on 12/10/24.
//

import SwiftUI
import SwiftData


@Model
final class Item {
    var title: String = ""
    var remarks: String = ""
    var category: String = ""
    var dateAdded: Date = Date.now
    var dateStarted: Date = Date.distantPast
    var dateCompleted: Date = Date.distantPast
    var status: Status.RawValue = Status.Hold.rawValue
    @Relationship(deleteRule: .cascade)
    var notes: [Note]?
    @Relationship(inverse: \STag.items)
    var sTags: [STag]?
    
    
    init(
        title: String = "",
        remarks: String = "",
        dateAdded: Date = Date.now,
        dateStarted: Date = Date .distantPast,
        dateCompleted: Date = Date.distantPast,
        category: String = "",
        status: Status = .Hold,
        sTags: [STag]? = nil
    ) {
        self.title = title
        self.remarks = remarks
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.category = category
        self.status = status.rawValue
        self.sTags = sTags
    }
    
    var icon: Image {
        switch Status(rawValue: status)! {
        case .Hold:
            Image(systemName: "checkmark.diamond.fill")
        case .Active:
            Image(systemName: "book.fill")
        case .Completed:
            Image(systemName: "books.vertical.fill")
        }
    }
}
enum Status: Int, Codable, Identifiable, CaseIterable {
    case Hold, Active, Completed
    var id: Self {
        self
    }
    var descr: LocalizedStringResource {
        switch self {
        case .Hold:
            "On Shelf"
        case .Active:
            "Active"
        case .Completed:
            "Completed"
        }
    }
}

