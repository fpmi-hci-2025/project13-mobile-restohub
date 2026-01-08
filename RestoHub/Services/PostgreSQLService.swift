import Foundation

class PostgreSQLService {
    static let shared = PostgreSQLService()
    
    // MARK: - Конфигурация
    private let baseURL = "http://localhost:3000/api"
    private let timeoutInterval: TimeInterval = 15
    
    private init() {}
    
    // MARK: - Проверка подключения
    func checkConnection() async -> Bool {
        print("🔗 Проверка подключения к серверу...")
        
        guard let url = URL(string: "\(baseURL)/health") else {
            print("❌ Неверный URL")
            return false
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ Неверный ответ сервера")
                return false
            }
            
            print("📡 HTTP статус: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode == 200 {
                // Пытаемся декодировать ответ
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let status = json["status"] as? String,
                   status == "ok" {
                    print("✅ Сервер доступен")
                    return true
                }
            }
            
            print("❌ Сервер недоступен или ответ неверный")
            return false
            
        } catch {
            print("❌ Ошибка подключения: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Основные методы
    
    func fetchAllRestaurants() async throws -> [Restaurant] {
        print("📊 Запрос всех ресторанов...")
        
        guard let url = URL(string: "\(baseURL)/restaurants") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = timeoutInterval
        
        print("🌐 Отправляем запрос: \(url.absoluteString)")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Логируем ответ
        await logResponse(data: data, response: response)
        
        // Проверяем HTTP статус
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NSError(
                domain: "API",
                code: statusCode,
                userInfo: [NSLocalizedDescriptionKey: "HTTP ошибка: \(statusCode)"]
            )
        }
        
        // Декодируем JSON
        return try decodeRestaurants(data: data)
    }
    
    func fetchRestaurantsByCategory(_ category: String) async throws -> [Restaurant] {
        print("📊 Запрос ресторанов по категории: \(category)")
        
        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? category
        guard let url = URL(string: "\(baseURL)/restaurants/category/\(encodedCategory)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = timeoutInterval
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try decodeRestaurants(data: data)
    }
    
    func searchRestaurants(query: String) async throws -> [Restaurant] {
        print("📊 Поиск ресторанов: \(query)")
        
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/restaurants/search?q=\(encodedQuery)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = timeoutInterval
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try decodeRestaurants(data: data)
    }
    
    // MARK: - Вспомогательные методы
    
    private func decodeRestaurants(data: Data) throws -> [Restaurant] {
        let decoder = JSONDecoder()
        
        // Настраиваем стратегию декодирования
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let restaurants = try decoder.decode([Restaurant].self, from: data)
            print("✅ Успешно декодировано \(restaurants.count) ресторанов")
            
            // Логируем первый ресторан для отладки
            if let first = restaurants.first {
                print("📋 Пример данных:")
                print("  ID: \(first.id)")
                print("  Name: \(first.name)")
                print("  Rating: \(first.rating)")
                print("  Category: \(first.category)")
            }
            
            return restaurants
            
        } catch {
            print("❌ Ошибка декодирования JSON: \(error)")
            
            // Подробная информация об ошибке
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .keyNotFound(let key, let context):
                    print("⚠️ Не найден ключ: \(key)")
                    print("   Путь: \(context.codingPath)")
                    print("   Описание: \(context.debugDescription)")
                case .typeMismatch(let type, let context):
                    print("⚠️ Несоответствие типа: \(type)")
                    print("   Путь: \(context.codingPath)")
                    print("   Описание: \(context.debugDescription)")
                case .valueNotFound(let type, let context):
                    print("⚠️ Не найдено значение: \(type)")
                    print("   Путь: \(context.codingPath)")
                    print("   Описание: \(context.debugDescription)")
                case .dataCorrupted(let context):
                    print("⚠️ Поврежденные данные")
                    print("   Описание: \(context.debugDescription)")
                @unknown default:
                    print("⚠️ Неизвестная ошибка декодирования")
                }
            }
            
            throw error
        }
    }
    
    private func logResponse(data: Data, response: URLResponse) async {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        print("📡 Ответ сервера: HTTP \(statusCode)")
        
        // Выводим первые 500 символов ответа для отладки
        if let responseString = String(data: data.prefix(500), encoding: .utf8) {
            print("📄 Ответ (первые 500 символов):")
            print(responseString)
        }
        
        // Если ответ большой, показываем только структуру
        if data.count > 500 {
            print("📦 Размер ответа: \(data.count) байт")
        }
    }
    
    // MARK: - Тестовые данные для fallback
    
    func getMockRestaurants() -> [Restaurant] {
        return [
            Restaurant(
                id: "mock-1",
                name: "Burger King (Mock)",
                description: "Fast food restaurant specializing in burgers",
                imageUrl: "burger_king",
                rating: 4.3,
                deliveryTime: "10-20 min",
                deliveryCost: "Delivery Free",
                category: "Burgers",
                isOpen: true,
                address: "ул. Пушкина 10",
                phone: "+375 29 123-45-67"
            ),
            Restaurant(
                id: "mock-2",
                name: "Pizza Hut (Mock)",
                description: "Pizza delivery",
                imageUrl: "pizza_hut",
                rating: 4.5,
                deliveryTime: "20-30 min",
                deliveryCost: "$2.99",
                category: "Pizza",
                isOpen: true,
                address: "пр. Независимости 25",
                phone: "+375 29 234-56-78"
            )
        ]
    }
}
