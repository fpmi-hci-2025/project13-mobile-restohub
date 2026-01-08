import Foundation

// Простая структура для работы с базой данных
struct RestaurantData {
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

extension Restaurant {
    // Инициализатор из RestaurantData
    init(data: RestaurantData) {
        self.id = data.id
        self.name = data.name
        self.description = data.description
        self.imageUrl = data.imageUrl
        self.rating = data.rating
        self.deliveryTime = data.deliveryTime
        self.deliveryCost = data.deliveryCost
        self.category = data.category
        self.isOpen = data.isOpen
        self.address = data.address
        self.phone = data.phone
    }
    
    // Инициализатор из словаря (например, из JSON)
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let name = dictionary["name"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.description = dictionary["description"] as? String ?? ""
        self.imageUrl = dictionary["image_url"] as? String ?? ""
        self.rating = dictionary["rating"] as? Double ?? 0.0
        self.deliveryTime = dictionary["delivery_time"] as? String ?? ""
        self.deliveryCost = dictionary["delivery_cost"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.isOpen = dictionary["is_open"] as? Bool ?? false
        self.address = dictionary["address"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
    }
}
