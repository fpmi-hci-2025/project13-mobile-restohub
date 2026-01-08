import Foundation

class DatabaseService {
    static let shared = DatabaseService()
    
    private let baseURL = "http://localhost:3000/api"
    
    // Получение всех ресторанов
    func fetchRestaurants() async throws -> [Restaurant] {
        guard let url = URL(string: "\(baseURL)/restaurants") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Декодирование JSON
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode([Restaurant].self, from: data)
    }
    
    // Фильтрация по категории
    func fetchRestaurantsByCategory(_ category: String) async throws -> [Restaurant] {
        guard let url = URL(string: "\(baseURL)/restaurants?category=\(category)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode([Restaurant].self, from: data)
    }
    
    // Поиск ресторанов
    func searchRestaurants(query: String) async throws -> [Restaurant] {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/restaurants/search?q=\(encodedQuery)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode([Restaurant].self, from: data)
    }
}
