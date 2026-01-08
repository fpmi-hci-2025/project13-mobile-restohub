//import SwiftUI
//
//struct MenuItemCard: View {
//    let item: MenuItem
//    let onAddToCart: () -> Void
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            // Название и цена
//            HStack {
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(item.name)
//                        .font(.system(size: 18, weight: .semibold))
//                    
//                    Text(item.description)
//                        .font(.system(size: 14))
//                        .foregroundColor(.gray)
//                }
//                
//                Spacer()
//                
//                Text(item.price)
//                    .font(.system(size: 16, weight: .semibold))
//                    .foregroundColor(.blue)
//            }
//            
//            // Кнопка добавления в корзину
//            Button(action: onAddToCart) {
//                Text("Add to cart")
//                    .font(.system(size: 14, weight: .medium))
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 10)
//                    .background(Color.blue)
//                    .cornerRadius(8)
//            }
//        }
//        .padding(16)
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
//    }
//}

// Views/Components/MenuItemCard.swift
import SwiftUI

struct MenuItemCard: View {
    let item: MenuItem
    let onAddToCart: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Изображение блюда
            Image(systemName: "fork.knife")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(item.description)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(2)
                
                Text("BYN \(item.price, specifier: "%.2f")")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Spacer()
            
            Button(action: onAddToCart) {
                Text("Add")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
        )
    }
}
