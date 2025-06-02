//
//  Focus_JournalApp.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI
import Adapty
import AdaptyUI

@main
struct Focus_JournalApp: App {
  
  init() {
    let configurationBuilder = AdaptyConfiguration.builder(withAPIKey: AppConstants.Adapty.apiKey)
    
    Task {
      do {
        try await Adapty.activate(with: configurationBuilder.build())
        try await AdaptyUI.activate()
      } catch {
        print("Failed to activate Adapty SDK: \(error)")
      }
    }
  }
  
  @State private var profileManager = ProfileManager()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(profileManager)
        .task {
          do {
            try await profileManager.refreshProfile()
          } catch {
            print("Error refreshing profile on launch: \(error)")
          }
        }
    }
  }
}
