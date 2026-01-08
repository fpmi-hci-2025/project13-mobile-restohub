// Models/Order.swift

import Foundation
struct Order: Identifiable, Codable {
    let id: String
    let userId: String
    let restaurantId: String
    let items: [CartItem]
    let totalAmount: Double
    let deliveryAddress: String
    let status: OrderStatus
    let createdAt: Date
    let estimatedDeliveryTime: Date
    
    enum OrderStatus: String, Codable {
        case pending, confirmed, preparing, onTheWay, delivered, cancelled
    }
}
