//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @EnvironmentObject var transactionData: TransactionData
    
    var body: some View {
        List {
            RingView(transactions: transactionData.transactions.filter{ $0.isPinned })
                .scaledToFit()
                .listRowInsets(EdgeInsets())
            ForEach(TransactionModel.Category.allCases.filter {$0 != .all}) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.headline)
                        .foregroundColor(category.color)
                    Spacer()
                    // TODO: calculate cummulative expense for each category
                    Text("$\(getSum(category:category).formatted())")
                        .bold()
                        .secondary()
                }.listRowInsets(EdgeInsets())
            }
        }.onAppear {
            UITableView.appearance().backgroundColor = .clear
        }.navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }

}

extension InsightsView {
    func getSum(category: TransactionModel.Category) -> Double {
        let filteredTransactions = transactionData.transactions.filter { $0.category == category && $0.isPinned }
        let sum = filteredTransactions.reduce(0) { $0 + $1.amount }
        return sum
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
            .previewLayout(.sizeThatFits)
    }
}
#endif
