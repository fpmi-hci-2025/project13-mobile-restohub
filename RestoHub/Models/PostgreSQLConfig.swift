import Foundation

// Конфигурация для подключения к PostgreSQL
struct PostgreSQLConfig {
    static let baseURL = "http://localhost:3000/api"
    
    // Endpoints
    static let restaurantsEndpoint = "\(baseURL)/restaurants"
    static let categoriesEndpoint = "\(baseURL)/categories"
    static let ordersEndpoint = "\(baseURL)/orders"
    
    static func menuEndpoint(for restaurantId: String) -> String {
        return "\(baseURL)/restaurants/\(restaurantId)/menu"
    }
}
