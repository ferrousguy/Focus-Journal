//
//  JournalEntry.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import Foundation

struct JournalEntry: Identifiable, Equatable {
  let id = UUID()
  let date: Date
  let entry: String
  
  init(date: Date = Date.now, entry: String) {
    self.date = date
    self.entry = entry
  }
}
