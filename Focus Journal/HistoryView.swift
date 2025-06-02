//
//  HistoryView.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
  @Environment(ProfileManager.self) private var profileManager
  
  var body: some View {
    List(profileManager.entries) { item in
      VStack(alignment: .leading, spacing: 4) {
        Text(item.date, format: .dateTime)
          .font(.subheadline)
          .foregroundStyle(.secondary)
        
        Text(item.entry)
      }
    }
    .navigationTitle("History")
  }
}
