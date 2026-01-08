// Views/Components/CategoriesView.swift
import SwiftUI

struct CategoriesView: View {
    let categories: [String]
    @Binding var selectedCategory: String
    var onCategorySelected: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(categories, id: \.self) { category in
                        CategoryChip(
                            title: category,
                            isSelected: selectedCategory == category
                        ) {
                            selectedCategory = category
                            onCategorySelected(category)
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
}

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .semibold : .regular))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.orange : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .orange)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.orange : Color.orange.opacity(0.5), lineWidth: 1.5)
                )
        }
    }
}
