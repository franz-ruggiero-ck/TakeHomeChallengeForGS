//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @State var selectedCategory: TransactionModel.Category = .all
    @EnvironmentObject var transactionData: TransactionData
    
    internal var didAppear: ((Self) -> Void)? // for ViewInspector testing purposes
    
    let categories = TransactionModel.Category.allCases
    
    var body: some View {
        VStack {
            CategoryListView(selectedCategory: $selectedCategory)
            
            List {
                ForEach(getTransactions(category: selectedCategory)) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())

            HStack {
                VStack (alignment: .trailing) {
                    Text(selectedCategory.rawValue)
                        .font(.headline)
                        .foregroundColor(selectedCategory.color)
                        
                    HStack{
                        Text("Total spent:")
                            .secondary()
                        
                        Spacer()
                        
                        Text("$\(getSum(category:selectedCategory).formatted())")
                            .primary()
                            .tag("sum")
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 2)
                )
            }.padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Transactions")
        .onAppear { self.didAppear?(self) } // for ViewInspector testing purposes
    }
}

extension TransactionListView {
    func getTransactions(category: TransactionModel.Category) -> [TransactionModel] {
        return transactionData.transactions.filter { category == .all || $0.category == category }
    }
    
    func getSum(category: TransactionModel.Category) -> Double {
        let filteredTransactions = transactionData.transactions.filter { (category == .all || $0.category == category) && $0.isPinned }
        let sum = filteredTransactions.reduce(0) { $0 + $1.amount }
        return sum
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
#endif
