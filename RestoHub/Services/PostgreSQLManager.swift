import Foundation

class PostgreSQLManager {
    static let shared = PostgreSQLManager()
    
    // Конфигурация подключения
    private let host = "localhost"
    private let port = 5432
    private let database = "RestoHub"
    private let username = "dashaignatenko"
    private let password = "" // ЗАМЕНИТЕ НА ВАШ ПАРОЛЬ
    
    private init() {}
    
    // MARK: - Основные методы
    
    // Получение всех ресторанов через SQL запрос (через локальный скрипт)
    func fetchAllRestaurants() async throws -> [Restaurant] {
        // Временное решение - возвращаем тестовые данные
        // В реальном проекте здесь будет вызов внешнего сервиса или локального скрипта
        
        print("📊 Запрос к PostgreSQL: SELECT * FROM restaurants")
        
        // Имитация задержки сети
        try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 секунды
        
        // Возвращаем тестовые данные
        return getMockRestaurants()
    }
    
    // Фильтрация по категории
    func fetchRestaurantsByCategory(_ category: String) async throws -> [Restaurant] {
        print("📊 Запрос к PostgreSQL: SELECT * FROM restaurants WHERE category = '\(category)'")
        
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 секунда
        
        let allRestaurants = getMockRestaurants()
        return allRestaurants.filter { $0.category == category }
    }
    
    // Поиск ресторанов
    func searchRestaurants(query: String) async throws -> [Restaurant] {
        print("📊 Запрос к PostgreSQL: SELECT * FROM restaurants WHERE name ILIKE '%\(query)%'")
        
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 секунда
        
        let allRestaurants = getMockRestaurants()
        return allRestaurants.filter {
            $0.name.localizedCaseInsensitiveContains(query) ||
            $0.category.localizedCaseInsensitiveContains(query)
        }
    }
    
    // MARK: - Вспомогательные методы
    
    // Тестовые данные - сделаем PUBLIC
    func getMockRestaurants() -> [Restaurant] {
        return [
            Restaurant(
                id: "1",
                name: "Burger King",
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
                id: "2",
                name: "Donnino's",
                description: "Pizza delivery",
                imageUrl: "donninos",
                rating: 4.5,
                deliveryTime: "30-50 min",
                deliveryCost: "Delivery Free",
                category: "Pizza",
                isOpen: true,
                address: "пр. Независимости 25",
                phone: "+375 29 234-56-78"
            ),
            Restaurant(
                id: "3",
                name: "KFC",
                description: "Fried chicken restaurant",
                imageUrl: "kfc",
                rating: 4.2,
                deliveryTime: "40-90 min",
                deliveryCost: "Delivery Free",
                category: "Burgers",
                isOpen: true,
                address: "ул. Ленина 15",
                phone: "+375 29 345-67-89"
            ),
            Restaurant(
                id: "4",
                name: "Mak.by",
                description: "Fast food",
                imageUrl: "mak",
                rating: 4.0,
                deliveryTime: "50-60 min",
                deliveryCost: "Delivery 2.0 BYN",
                category: "Burgers",
                isOpen: true,
                address: "ул. Советская 8",
                phone: "+375 29 456-78-90"
            ),
            Restaurant(
                id: "5",
                name: "DOD PIZZ",
                description: "Pizza restaurant",
                imageUrl: "dodpizz",
                rating: 4.6,
                deliveryTime: "35-45 min",
                deliveryCost: "Delivery Free",
                category: "Pizza",
                isOpen: true,
                address: "ул. Октябрьская 12",
                phone: "+375 29 567-89-01"
            ),
            Restaurant(
                id: "6",
                name: "Ronin",
                description: "Sushi restaurant",
                imageUrl: "ronin",
                rating: 4.7,
                deliveryTime: "25-40 min",
                deliveryCost: "$0",
                category: "Sushi",
                isOpen: true,
                address: "пр. Победителей 45",
                phone: "+375 29 678-90-12"
            ),
            Restaurant(
                id: "7",
                name: "Mapyми",
                description: "Japanese cuisine",
                imageUrl: "mapymi",
                rating: 4.4,
                deliveryTime: "20-35 min",
                deliveryCost: "$0",
                category: "Sushi",
                isOpen: true,
                address: "ул. Купалы 3",
                phone: "+375 29 789-01-23"
            ),
            Restaurant(
                id: "8",
                name: "Пицца Додо",
                description: "Pizza delivery",
                imageUrl: "pizza_dodo",
                rating: 4.5,
                deliveryTime: "30-45 min",
                deliveryCost: "4",
                category: "Pizza",
                isOpen: true,
                address: "ул. Гоголя 7",
                phone: "+375 29 890-12-34"
            )
        ]
    }
    
    // Проверка подключения
    func checkConnection() async -> Bool {
        print("🔗 Проверка подключения к PostgreSQL...")
        
        // Имитация проверки подключения
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 секунды
        
        // В реальном проекте здесь будет реальная проверка
        let isConnected = true // или false в зависимости от доступности
        
        if isConnected {
            print("✅ PostgreSQL доступен")
        } else {
            print("❌ PostgreSQL недоступен")
        }
        
        return isConnected
    }
}
