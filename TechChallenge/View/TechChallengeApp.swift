//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

@main
struct TechChallengeApp: App {
    
    @StateObject var transactionData = TransactionData()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView()
                    
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }.environmentObject(transactionData)
                
                NavigationView {
                    InsightsView()
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }.environmentObject(transactionData)
            }
        }
    }
}
