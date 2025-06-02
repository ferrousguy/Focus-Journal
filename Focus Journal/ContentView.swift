//
//  ContentView.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      HomeView()
        .navigationTitle("Focus Journal")
    }
  }
}

#Preview {
  @Previewable @State var profileManager = ProfileManager()
  
  ContentView()
    .environment(profileManager)
}
