// Models/Restaurant.swift
struct Restaurant: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let imageUrl: String
    let rating: Double
    let deliveryTime: String
    let deliveryCost: String
    let category: String
    let isOpen: Bool
    let address: String
    let phone: String
}

//
//import Foundation
//
//struct Restaurant: Identifiable, Codable {
//    let id: String
//    let name: String
//    let description: String?
//    let imageUrl: String?
//    let rating: Double
//    let deliveryTime: String?
//    let deliveryCost: String?
//    let category: String
//    let isOpen: Bool?
//    let address: String?
//    let phone: String?
//    
//    // MARK: - Coding Keys
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case description
//        case imageUrl = "image_url"
//        case rating
//        case deliveryTime = "delivery_time"
//        case deliveryCost = "delivery_cost"
//        case category
//        case isOpen = "is_open"
//        case address
//        case phone
//    }
//    
//    // MARK: - Custom Initializer
//    init(id: String,
//         name: String,
//         description: String? = nil,
//         imageUrl: String? = nil,
//         rating: Double = 0.0,
//         deliveryTime: String? = nil,
//         deliveryCost: String? = nil,
//         category: String = "",
//         isOpen: Bool? = nil,
//         address: String? = nil,
//         phone: String? = nil) {
//        self.id = id
//        self.name = name
//        self.description = description
//        self.imageUrl = imageUrl
//        self.rating = rating
//        self.deliveryTime = deliveryTime
//        self.deliveryCost = deliveryCost
//        self.category = category
//        self.isOpen = isOpen
//        self.address = address
//        self.phone = phone
//    }
//    
//    // MARK: - Computed Properties
//    var formattedRating: String {
//        return String(format: "%.1f", rating)
//    }
//    
//    var isOpenText: String {
//        return (isOpen ?? false) ? "Открыто" : "Закрыто"
//    }
//    
//    var safeDescription: String {
//        return description ?? "Описание отсутствует"
//    }
//    
//    var safeImageUrl: String {
//        return imageUrl ?? "restaurant_placeholder"
//    }
//}
