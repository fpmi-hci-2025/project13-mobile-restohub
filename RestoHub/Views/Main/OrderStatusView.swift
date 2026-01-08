//import SwiftUI
//
//struct OrderStatusView: View {
//    let order: Order
//    @Environment(\.presentationMode) var presentationMode
//    
//    let statusSteps = [
//        "Order accepted",
//        "Preparing",
//        "On the way",
//        "Delivered"
//    ]
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            NavigationBarView(
//                title: "Order status",
//                showBackButton: true,
//                trailingButtons: true
//            )
//            
//            ScrollView {
//                VStack(spacing: 24) {
//                    // Информация о заказе
//                    VStack(alignment: .leading, spacing: 16) {
//                        HStack {
//                            VStack(alignment: .leading, spacing: 4) {
//                                Text("Order #\(order.id)")
//                                    .font(.system(size: 18, weight: .semibold))
//                                
//                                Text(order.restaurantName)
//                                    .font(.system(size: 14))
//                                    .foregroundColor(.gray)
//                            }
//                            
//                            Spacer()
//                            
//                            Text(order.total)
//                                .font(.system(size: 18, weight: .semibold))
//                                .foregroundColor(.blue)
//                        }
//                        .padding(.bottom, 8)
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.top, 20)
//                    
//                    // Кнопки действий
//                    VStack(spacing: 12) {
//                        Button(action: {
//                            presentationMode.wrappedValue.dismiss()
//                        }) {
//                            Text("Back to orders")
//                                .font(.system(size: 16, weight: .medium))
//                                .foregroundColor(.blue)
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical, 14)
//                                .background(Color.blue.opacity(0.1))
//                                .cornerRadius(10)
//                        }
//                        
//                        Button(action: {
//                            // Навигация на главную
//                        }) {
//                            Text("Go to home")
//                                .font(.system(size: 16, weight: .semibold))
//                                .foregroundColor(.white)
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical, 14)
//                                .background(Color.blue)
//                                .cornerRadius(10)
//                        }
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.top, 20)
//                }
//                .padding(.bottom, 20)
//            }
//        }
//        .background(Color(.systemBackground))
//    }
//}

// Views/Main/OrderStatusView.swift
import SwiftUI

struct OrderStatusView: View {
    let order: Order
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Навигационная панель
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        Text("Order Status")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Spacer()
                            .frame(width: 40)
                    }
                    .frame(height: 60)
                    .background(Color.black)
                    
                    ScrollView {
                        VStack(spacing: 30) {
                            // Статус заказа
                            VStack(spacing: 20) {
                                Circle()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.orange.opacity(0.2))
                                    .overlay(
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 60))
                                            .foregroundColor(.orange)
                                    )
                                
                                VStack(spacing: 8) {
                                    Text("Order Confirmed")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Text("Order #\(order.id.prefix(8))")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("Estimated delivery: \(formattedDeliveryTime)")
                                        .font(.system(size: 14))
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding(.top, 40)
                            
                            // Прогресс доставки
                            VStack(spacing: 20) {
                                OrderProgressStep(
                                    title: "Order Confirmed",
                                    isCompleted: true,
                                    time: "10:30 AM"
                                )
                                
                                OrderProgressStep(
                                    title: "Preparing",
                                    isCompleted: true,
                                    time: "10:45 AM"
                                )
                                
                                OrderProgressStep(
                                    title: "On the way",
                                    isCompleted: false,
                                    time: "Expected: 11:30 AM"
                                )
                                
                                OrderProgressStep(
                                    title: "Delivered",
                                    isCompleted: false,
                                    time: "Expected: 11:45 AM"
                                )
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var formattedDeliveryTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: order.estimatedDeliveryTime)
    }
}

struct OrderProgressStep: View {
    let title: String
    let isCompleted: Bool
    let time: String
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .frame(width: 24, height: 24)
                .foregroundColor(isCompleted ? .orange : .gray.opacity(0.5))
                .overlay(
                    Image(systemName: isCompleted ? "checkmark" : "")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isCompleted ? .white : .white.opacity(0.7))
                
                Text(time)
                    .font(.system(size: 14))
                    .foregroundColor(isCompleted ? .orange : .white.opacity(0.5))
            }
            
            Spacer()
        }
    }
}
