//
//  ProfileManager.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import Foundation
import Observation
import Adapty

@Observable
final class ProfileManager {
  var customerProfile: AdaptyProfile? {
    didSet {
      if let accessLevel = customerProfile?.accessLevels[AppConstants.Adapty.accessLevelID],
         accessLevel.isActive || accessLevel.isInGracePeriod || accessLevel.isLifetime {
        isPremium = true
      } else {
        isPremium = false
      }
    }
  }
  
  var isPremium: Bool = false
  var entries: [JournalEntry] = []
  
  init() {
    entries.append(JournalEntry(date: Date().addingTimeInterval(-92304 * 2), entry: "Good focus day"))
    entries.append(JournalEntry(date: Date().addingTimeInterval(-64100), entry: "Planning session"))
  }
  
  func purchasePremium() {
    // Mock unlock for demo
    isPremium = true
  }
  
  func subscriptionPurchased(with updatedProfile: AdaptyProfile) {
    customerProfile = updatedProfile
  }
  
  func refreshProfile() async throws {
    customerProfile = try await Adapty.getProfile()
  }
  
  func addEntry(_ text: String) {
    let newEntry = JournalEntry(entry: text)
    entries.append(newEntry)
  }
}
