//import SwiftUI
//
//struct OrdersView: View {
//    @EnvironmentObject var ordersViewModel: OrdersViewModel
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            NavigationBarView(
//                title: "My orders",
//                showBackButton: false,
//                trailingButtons: true
//            )
//            
//            // Список заказов
//            ScrollView {
//                LazyVStack(spacing: 16) {
//                    ForEach(ordersViewModel.orders) { order in
//                        OrderCard(order: order)
//                            .padding(.horizontal)
//                    }
//                }
//                .padding(.vertical)
//            }
//            
//            Spacer()
//                    }
//        .navigationBarHidden(true)
//    }
//}
//
//struct OrderCard: View {
//    let order: Order
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            HStack {
//                Text("Order #\(order.id)")
//                    .font(.headline)
//                Spacer()
//                Text(order.total)
//                    .font(.headline)
//                    .foregroundColor(.blue)
//            }
//            
//            Text("\(order.items.count) items")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//            
//            Text(order.status)
//                .font(.caption)
//                .padding(.horizontal, 12)
//                .padding(.vertical, 4)
//                .background(
//                    order.status == "Delivered" ? Color.green.opacity(0.2) : Color.orange.opacity(0.2)
//                )
//                .foregroundColor(
//                    order.status == "Delivered" ? .green : .orange
//                )
//                .cornerRadius(8)
//                .frame(maxWidth: .infinity, alignment: .trailing)
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
//    }
//}

// Views/Main/OrdersView.swift
import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Навигационная панель
                    HStack {
                        Text("Orders")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                        
                        Spacer()
                        
                        Spacer()
                            .frame(width: 60)
                    }
                    .frame(height: 60)
                    .background(Color.black)
                    
                    // Сегментированный контрол
                    HStack(spacing: 0) {
                        Button(action: {
                            selectedSegment = 0
                        }) {
                            Text("Active")
                                .font(.system(size: 16, weight: selectedSegment == 0 ? .semibold : .medium))
                                .foregroundColor(selectedSegment == 0 ? .white : .white.opacity(0.6))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(selectedSegment == 0 ? Color.orange : Color.clear)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            selectedSegment = 1
                        }) {
                            Text("History")
                                .font(.system(size: 16, weight: selectedSegment == 1 ? .semibold : .medium))
                                .foregroundColor(selectedSegment == 1 ? .white : .white.opacity(0.6))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(selectedSegment == 1 ? Color.orange : Color.clear)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.black)
                    
//                    if ordersViewModel.orders.isEmpty {
//                        VStack(spacing: 20) {
//                            Image(systemName: "bag")
//                                .font(.system(size: 80))
//                                .foregroundColor(.orange.opacity(0.5))
//                            
//                            Text("No orders yet")
//                                .font(.system(size: 20, weight: .medium))
//                                .foregroundColor(.white)
//                            
//                            Text("Your orders will appear here")
//                                .font(.system(size: 14))
//                                .foregroundColor(.white.opacity(0.7))
//                        }
//                        .padding(.top, 100)
//                    } else {
//                        ScrollView {
//                            LazyVStack(spacing: 16) {
//                                ForEach(filteredOrders) { order in
//                                    OrderCard(order: order)
//                                        .padding(.horizontal)
//                                }
//                            }
//                            .padding(.vertical)
//                        }
//                    }
                    
                    Spacer()
                }
                .navigationBarHidden(true)
            }
        }
        .onAppear {
            if let userId = userViewModel.currentUser?.id {
                ordersViewModel.fetchOrders(userId: userId)
            }
        }
    }
    
    private var filteredOrders: [Order] {
        let activeStatuses: [Order.OrderStatus] = [.pending, .confirmed, .preparing, .onTheWay]
        
        if selectedSegment == 0 {
            return ordersViewModel.orders.filter { activeStatuses.contains($0.status) }
        } else {
            return ordersViewModel.orders.filter { !activeStatuses.contains($0.status) }
        }
    }
}

struct OrderCard: View {
    let order: Order
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Order #\(order.id.prefix(8))")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(ordersViewModel.getStatusColor(order.status))
                        
                        Text(ordersViewModel.getOrderStatusText(order.status))
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Text("Total: BYN \(order.totalAmount, specifier: "%.2f")")
                        .font(.system(size: 14))
                        .foregroundColor(.orange)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    Text(formattedDate(order.createdAt))
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Button(action: {
                        // Просмотр деталей заказа
                    }) {
                        Text("View")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.orange)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }
            
            Divider()
                .background(Color.orange.opacity(0.2))
            
            HStack {
                Text("\(order.items.count) items")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
                
                Spacer()
                
                Text("Delivery: \(formattedDeliveryTime(order.estimatedDeliveryTime))")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
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
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func formattedDeliveryTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
