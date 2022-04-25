//
//  CategoryListView.swift
//  TechChallenge
//

//

import SwiftUI

struct CategoryListView: View {
    @Binding var selectedCategory : TransactionModel.Category
    let categories = TransactionModel.Category.allCases
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing:10){
                ForEach(categories){ category in
                    CategoryView(selectedCategory: $selectedCategory, category: category)
                }
            }.padding()
        }
        .frame(height:70)
        .background(Color.accentColor.opacity(0.8))
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(selectedCategory: .constant(.all))
    }
}
