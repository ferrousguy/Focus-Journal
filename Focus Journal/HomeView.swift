//
//  HomeView.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI
import Adapty
import AdaptyUI

struct HomeView: View {
  @Environment(ProfileManager.self) private var profileManager
  
  @State private var entryText: String = ""
  @State private var paywallConfig: AdaptyUI.PaywallConfiguration?
  
  @State private var isShowingPaywall = false
  @State private var isShowingHistory = false
  
  var body: some View {
    VStack(spacing: 20) {
      Text("What was your focus today?")
        .font(.headline)
      
      TextField("Enter your thoughts...", text: $entryText)
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal)
      
      Button(action: saveEntry) {
        Text("Save Entry")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(8)
      }
      .padding(.horizontal)
      
      Spacer()
      
      Button {
        if profileManager.isPremium {
          isShowingHistory = true
        } else {
          isShowingPaywall = true
        }
      } label: {
        Text("View History")
      }
      .buttonStyle(.bordered)
    }
    .sheet(isPresented: $isShowingHistory) {
      NavigationStack {
        HistoryView()
      }
    }
    .iflet(paywallConfig, transform: { view, unwrappedPaywallConfig in
      view.paywall(
        isPresented: $isShowingPaywall,
        fullScreen: false,
        paywallConfiguration: paywallConfig,
        didFinishPurchase: { _, purchaseResult in
          switch purchaseResult {
            case .success(let profile, _):
              profileManager.subscriptionPurchased(with: profile)
            default:
              break
          }
          isShowingPaywall = false
        },
        didFailPurchase: { _, error in
          isShowingPaywall = false
          // TODO: Present error to user and offer alternative
        },
        didFinishRestore: { profile in
          profileManager.subscriptionPurchased(with: profile)
          isShowingPaywall = false
        },
        didFailRestore: { error in
          isShowingPaywall = false
          // TODO: Present error to user and offer alternative
        },
        didFailRendering: { error in
          isShowingPaywall = false
          // TODO: Present error to user and offer alternative
        })
    })
    .task {
      do {
        if !profileManager.isPremium {
          let paywall = try await Adapty.getPaywall(placementId: AppConstants.Adapty.placementID)
          paywallConfig = try await AdaptyUI.getPaywallConfiguration(forPaywall: paywall)
        }
      } catch {
        print("Error fetching paywall or paywall config: \(error)")
      }
    }
  }
  
  func saveEntry() {
    guard !entryText.isEmpty else { return }
    profileManager.addEntry(entryText)
    entryText = ""
  }
}
