//
//  CategoryView.swift
//  TechChallenge
//

//

import SwiftUI

struct CategoryView: View {
    @Binding var selectedCategory : TransactionModel.Category
    let category: TransactionModel.Category
    
    var body: some View {
        Button(action: {
           withAnimation{
               self.selectedCategory = category
           }
        }) {
            Text(category.rawValue)
                .font(.system(.title2))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .frame(height: 40)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .background(category.color)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(selectedCategory: .constant(.all), category: .entertainment)
    }
}
