//
//  ProfileManager.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import Foundation
import Observation

@Observable
final class ProfileManager {
  var isPremium: Bool = false
  var entries: [JournalEntry] = []
  
  init() {
    entries.append(JournalEntry(date: Date().addingTimeInterval(-92304 * 2), entry: "Good focus day"))
    entries.append(JournalEntry(date: Date().addingTimeInterval(-64100), entry: "Planning session"))
  }
  
  func subscriptionPurchased() {
    // Mock unlock for demo
    isPremium = true
  }
  
  func addEntry(_ text: String) {
    let newEntry = JournalEntry(entry: text)
    entries.append(newEntry)
  }
}
