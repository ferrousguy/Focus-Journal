//
//  Focus_JournalApp.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

@main
struct Focus_JournalApp: App {
  
  init() {}
  
  @State private var profileManager = ProfileManager()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(profileManager)
    }
  }
}
