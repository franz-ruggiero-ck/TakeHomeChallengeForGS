//
//  TransactionData.swift
//  TechChallenge
//

//

import Foundation

class TransactionData: ObservableObject {
    @Published var transactions = ModelData.sampleTransactions
}
