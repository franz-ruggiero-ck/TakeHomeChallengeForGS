//
//  RingView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

fileprivate typealias Category = TransactionModel.Category

struct RingView: View {
    let transactions: [TransactionModel]
    let categories = Category.allCases.filter{ $0 != .all }
    
    private func ratio(for categoryIndex: Int) -> Double {
        // TODO: calculate ratio for each category according to cummulative expense
        
        // Returning sample value
        let total = transactions.reduce(0) { $0 + $1.amount }
        let filteredTransactions = transactions.filter { $0.category == categories[categoryIndex] }
        let sum = filteredTransactions.reduce(0) { $0 + $1.amount }
        return sum / total
    }
    
    private func offset(for categoryIndex: Int) -> Double {
        // TODO: calculate offset for each category according to cummulative expense
        
        // Returning sample value

        var offset = 0.0
        
        if (categoryIndex > 0){
            for idx in 0...categoryIndex-1 {
                offset += ratio(for: idx)
            }
        }
        
        return offset
    }

    private func gradient(for categoryIndex: Int) -> AngularGradient {
        let color = categories[categoryIndex].color
        return AngularGradient(
            gradient: Gradient(colors: [color.unsaturated, color]),
            center: .center,
            startAngle: .init(
                offset: offset(for: categoryIndex),
                ratio: 0
            ),
            endAngle: .init(
                offset: offset(for: categoryIndex),
                ratio: ratio(for: categoryIndex)
            )
        )
    }
    
    private func percentageText(for categoryIndex: Int) -> String {
        "\((ratio(for: categoryIndex) * 100).formatted(hasDecimals: false))%"
    }
    
    var body: some View {
        ZStack {
            ForEach(categories.indices) { categoryIndex in
                PartialCircleShape(
                    offset: offset(for: categoryIndex),
                    ratio: ratio(for: categoryIndex)
                )
                .stroke(
                    gradient(for: categoryIndex),
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
                .overlay(
                    PercentageText(
                        offset: offset(for: categoryIndex),
                        ratio: ratio(for: categoryIndex),
                        text: percentageText(for: categoryIndex)
                    )
                )
            }
        }
    }
}

extension RingView {
    struct PartialCircleShape: Shape {
        let offset: Double
        let ratio: Double
        
        func path(in rect: CGRect) -> Path {
            Path(offset: offset, ratio: ratio, in: rect)
        }
    }
    
    struct PercentageText: View {
        let offset: Double
        let ratio: Double
        let text: String
        
        private func position(for geometry: GeometryProxy) -> CGPoint {
            let rect = geometry.frame(in: .local)
            let path = Path(offset: offset, ratio: ratio / 2.0, in: rect)
            return path.currentPoint ?? .zero
        }
        
        var body: some View {
            if (ratio >= 0.03){
                GeometryReader { geometry in
                    Text(text)
                        .percentage()
                        .position(position(for: geometry))
                }
            }else{
                EmptyView()
            }
        }
    }
}

#if DEBUG
struct RingView_Previews: PreviewProvider {
    static var sampleRing: some View {
        ZStack {
            RingView.PartialCircleShape(offset: 0.0, ratio: 0.15)
                .stroke(
                    Color.red,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
            
            RingView.PartialCircleShape(offset: 0.15, ratio: 0.5)
                .stroke(
                    Color.green,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
                
            RingView.PartialCircleShape(offset: 0.65, ratio: 0.35)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
        }
    }
    
    static var previews: some View {
        VStack {
            sampleRing
                .scaledToFit()
            
            RingView(transactions: ModelData.sampleTransactions)
                .scaledToFit()
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
