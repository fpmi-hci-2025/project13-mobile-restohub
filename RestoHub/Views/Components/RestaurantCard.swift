//import SwiftUI
//
//struct RestaurantCard: View {
//    let restaurant: Restaurant
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            // Название и рейтинг
//            HStack {
//                Text(restaurant.name)
//                    .font(.headline)
//                
//                Spacer()
//                
//                if let rating = restaurant.rating {
//                    HStack(spacing: 4) {
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
//                            .font(.system(size: 12))
//                        Text(String(format: "%.1f", rating))
//                            .font(.caption)
//                    }
//                }
//            }
//            
//            // Информация о доставке
//            HStack {
//                Text(restaurant.deliveryTime)
//                Text("•")
//                Text("Delivery: \(restaurant.deliveryFee)")
//            }
//            .font(.subheadline)
//            .foregroundColor(.gray)
//            
//            // Тип кухни
//            Text(restaurant.type)
//                .font(.caption)
//                .foregroundColor(.blue)
//            
//            Divider()
//                .padding(.top, 8)
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
//    }
//}
// Views/Components/RestaurantCard.swift
//import SwiftUI
//
//struct RestaurantCard: View {
//    let restaurant: Restaurant
//    
//    var body: some View {
//        HStack(spacing: 12) {
//            // Иконка ресторана - оранжевая
//            RestaurantIconView(category: restaurant.category)
//            
//            RestaurantInfoView(restaurant: restaurant)
//            
//            Spacer()
//            
//            // Рейтинг - оранжевый
//            RatingView(rating: restaurant.rating)
//        }
//        .padding()
//        .background(Color.gray.opacity(0.1))
//        .cornerRadius(12)
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
//        )
//    }
//}
//
//struct RestaurantIconView: View {
//    let category: String
//    
//    var body: some View {
//        ZStack {
//            Circle()
//                .fill(Color.gray.opacity(0.2))
//                .frame(width: 60, height: 60)
//            
//            Image(systemName: getIconForCategory(category))
//                .resizable()
//                .scaledToFit()
//                .frame(width: 30, height: 30)
//                .foregroundColor(.orange)
//        }
//    }
//    
//    private func getIconForCategory(_ category: String) -> String {
//        switch category {
//        case "Pizza":
//            return "fork.knife.circle.fill"
//        case "Burgers":
//            return "takeoutbag.and.cup.and.straw.fill"
//        case "Sushi":
//            return "leaf.circle.fill"
//        case "Shields":
//            return "shield.checkered"
//        default:
//            return "building.2.fill"
//        }
//    }
//}
//
//struct RestaurantInfoView: View {
//    let restaurant: Restaurant
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            Text(restaurant.name)
//                .font(.system(size: 16, weight: .semibold))
//                .foregroundColor(.white)
//            
//            RestaurantDetailsView(restaurant: restaurant)
//            
//            // Статус ресторана - оранжевый если открыт
//            RestaurantStatusView(isOpen: restaurant.isOpen)
//                .padding(.top, 2)
//        }
//    }
//}
//
//struct RestaurantDetailsView: View {
//    let restaurant: Restaurant
//    
//    var body: some View {
//        HStack(spacing: 8) {
//            HStack(spacing: 4) {
//                Image(systemName: "clock")
//                    .font(.system(size: 12))
//                    .foregroundColor(.orange)
//                
//                Text(restaurant.deliveryTime)
//                    .font(.system(size: 12))
//                    .foregroundColor(.white.opacity(0.8))
//            }
//            
//            Text("•")
//                .foregroundColor(.orange)
//            
//            Text(restaurant.deliveryCost)
//                .font(.system(size: 12))
//                .foregroundColor(.white.opacity(0.8))
//            
//            Text("•")
//                .foregroundColor(.orange)
//            
//            Text(restaurant.category)
//                .font(.system(size: 12))
//                .foregroundColor(.white.opacity(0.8))
//        }
//    }
//}
//
//struct RestaurantStatusView: View {
//    let isOpen: Bool
//    
//    var body: some View {
//        HStack(spacing: 4) {
//            Circle()
//                .fill(isOpen ? Color.green : Color.red)
//                .frame(width: 6, height: 6)
//            
//            Text(isOpen ? "Open Now" : "Closed")
//                .font(.system(size: 11))
//                .foregroundColor(isOpen ? .green : .red)
//        }
//    }
//}
//
//struct RatingView: View {
//    let rating: Double
//    
//    var body: some View {
//        HStack(spacing: 4) {
//            Image(systemName: "star.fill")
//                .font(.system(size: 12))
//                .foregroundColor(.orange)
//            
//            Text(String(format: "%.1f", rating))
//                .font(.system(size: 14, weight: .medium))
//                .foregroundColor(.white)
//        }
//        .padding(.horizontal, 8)
//        .padding(.vertical, 4)
//        .background(Color.orange.opacity(0.1))
//        .cornerRadius(8)
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
//        )
//    }
//}

import SwiftUI

struct RestaurantCard: View {
    let restaurant: Restaurant
    
    var body: some View {
        HStack(spacing: 12) {
            // Иконка ресторана - оранжевая
            RestaurantIconView(category: restaurant.category ?? "Unknown")
            
            RestaurantInfoView(restaurant: restaurant)
            
            Spacer()
            
            // Рейтинг - оранжевый
            RatingView(rating: restaurant.rating ?? 0.0)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
        )
    }
}

struct RestaurantIconView: View {
    let category: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 60, height: 60)
            
            Image(systemName: getIconForCategory(category))
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.orange)
        }
    }
    
    private func getIconForCategory(_ category: String) -> String {
        switch category {
        case "Pizza":
            return "fork.knife.circle.fill"
        case "Burgers":
            return "takeoutbag.and.cup.and.straw.fill"
        case "Sushi":
            return "leaf.circle.fill"
        case "Shields":
            return "shield.checkered"
        default:
            return "building.2.fill"
        }
    }
}

struct RestaurantInfoView: View {
    let restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(restaurant.name ?? "Unknown Restaurant")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            
            RestaurantDetailsView(restaurant: restaurant)
            
            // Статус ресторана - оранжевый если открыт
            RestaurantStatusView(isOpen: restaurant.isOpen ?? false)
                .padding(.top, 2)
        }
    }
}

struct RestaurantDetailsView: View {
    let restaurant: Restaurant
    
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: "clock")
                    .font(.system(size: 12))
                    .foregroundColor(.orange)
                
                Text(restaurant.deliveryTime ?? "N/A")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Text("•")
                .foregroundColor(.orange)
            
            Text(restaurant.deliveryCost ?? "N/A")
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.8))
            
            Text("•")
                .foregroundColor(.orange)
            
            Text(restaurant.category ?? "Unknown")
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

struct RestaurantStatusView: View {
    let isOpen: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(isOpen ? Color.green : Color.red)
                .frame(width: 6, height: 6)
            
            Text(isOpen ? "Open Now" : "Closed")
                .font(.system(size: 11))
                .foregroundColor(isOpen ? .green : .red)
        }
    }
}

struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundColor(.orange)
            
            Text(String(format: "%.1f", rating))
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.orange.opacity(0.1))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
        )
    }
}
