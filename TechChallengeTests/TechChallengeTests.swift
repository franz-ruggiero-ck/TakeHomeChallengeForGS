//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
import SwiftUI
import ViewInspector

@testable import TechChallenge

class TechChallengeTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTransactionFilteringByCategory(){
        let transactionData = TransactionData()
        var subject = TransactionListView()

        let exp = subject.on(\.didAppear) { view in
            do{
                try view.actualView().selectedCategory = .food
                let sum = try view.find(viewWithTag: "sum").text().string()
                
                let foodTransactions = transactionData.transactions.filter { ($0.category == .food) && $0.isPinned }
                let sumOnFood = foodTransactions.reduce(0) { $0 + $1.amount }

                XCTAssertEqual(sum, "$\(sumOnFood.formatted())")
            }catch {
                XCTFail("Fail: \(error)")
            }
        }
        ViewHosting.host(view: subject.environmentObject(transactionData))
        wait(for: [exp], timeout: 0.1)
        
    }

}

extension TransactionListView: Inspectable {}
