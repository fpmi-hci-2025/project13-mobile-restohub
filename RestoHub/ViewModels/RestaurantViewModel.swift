import Foundation
import SwiftUI
internal import Combine

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var filteredRestaurants: [Restaurant] = []
    @Published var isLoading = false
    
    init() {
        loadMockData()
        filteredRestaurants = restaurants
    }
    
    func loadMockData() {
        restaurants = [
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
    
    func filterRestaurants(by category: String) {
        if category == "All" {
            filteredRestaurants = restaurants
        } else {
            filteredRestaurants = restaurants.filter { $0.category == category }
        }
    }
    
    func searchRestaurants(query: String) {
        if query.isEmpty {
            filteredRestaurants = restaurants
        } else {
            filteredRestaurants = restaurants.filter {
                $0.name.localizedCaseInsensitiveContains(query) ||
                $0.category.localizedCaseInsensitiveContains(query)
            }
        }
    }
}
//import Foundation
//import SwiftUI
//internal import Combine
//
//@MainActor
//class RestaurantViewModel: ObservableObject {
//    @Published var restaurants: [Restaurant] = []
//    @Published var filteredRestaurants: [Restaurant] = []
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    @Published var connectionStatus = "Инициализация..."
//    @Published var lastUpdate = Date()
//    
//    private let dataService = RestaurantDataService.shared
//    
//    init() {
//        print("🚀 RestaurantViewModel инициализирован")
//        setupObservers()
//        loadRestaurants()
//    }
//    
//    private func setupObservers() {
//        // Подписываемся на изменения статуса подключения
//        Task {
//            for await status in dataService.$connectionStatus.values {
//                connectionStatus = status
//            }
//        }
//    }
//    
//    // MARK: - Загрузка данных
//    
//    func loadRestaurants() {
//        print("🔄 Начинаем загрузку ресторанов...")
//        
//        isLoading = true
//        errorMessage = nil
//        
//        Task {
//            do {
//                print("📥 Запрашиваем данные у сервиса...")
//                let fetchedRestaurants = try await dataService.fetchRestaurants()
//                
//                print("✅ Получено данных: \(fetchedRestaurants.count) ресторанов")
//                
//                // Обновляем UI
//                self.restaurants = fetchedRestaurants
//                self.filteredRestaurants = fetchedRestaurants
//                self.lastUpdate = Date()
//                
//                // Логируем для отладки
//                if fetchedRestaurants.isEmpty {
//                    print("⚠️ Получен пустой массив ресторанов")
//                } else {
//                    print("📋 Пример первого ресторана:")
//                    let first = fetchedRestaurants[0]
//                    print("  ID: \(first.id)")
//                    print("  Name: \(first.name)")
//                    print("  Rating: \(first.rating)")
//                    print("  Category: \(first.category)")
//                }
//                
//            } catch {
//                print("❌ Критическая ошибка загрузки: \(error)")
//                
//                // Показываем ошибку пользователю
//                self.errorMessage = "Не удалось загрузить рестораны: \(error.localizedDescription)"
//                
//                // Используем тестовые данные как запасной вариант
////                let mockRestaurants = dataService.getMockRestaurants()
////                self.restaurants = mockRestaurants
////                self.filteredRestaurants = mockRestaurants
//                self.connectionStatus = "⚠️ Используются тестовые данные (ошибка)"
//            }
//            
//            isLoading = false
//            print("🏁 Загрузка завершена")
//        }
//    }
//    
//    // MARK: - Фильтрация и поиск
//    
//    func filterRestaurants(by category: String) {
//        print("🔍 Фильтрация по категории: \(category)")
//        
//        isLoading = true
//        
//        Task {
//            do {
//                let filtered = try await dataService.filterRestaurants(by: category)
//                filteredRestaurants = filtered
//                print("✅ Отфильтровано: \(filtered.count) ресторанов")
//            } catch {
//                print("❌ Ошибка фильтрации: \(error)")
//                // Локальная фильтрация как fallback
//                if category == "All" {
//                    filteredRestaurants = restaurants
//                } else {
//                    filteredRestaurants = restaurants.filter { $0.category == category }
//                }
//            }
//            
//            isLoading = false
//        }
//    }
//    
//    func searchRestaurants(query: String) {
//        print("🔍 Поиск: '\(query)'")
//        
//        isLoading = true
//        
//        Task {
//            do {
//                let results = try await dataService.searchRestaurants(query: query)
//                filteredRestaurants = results
//                print("✅ Найдено: \(results.count) ресторанов")
//            } catch {
//                print("❌ Ошибка поиска: \(error)")
//                // Локальный поиск как fallback
//                if query.isEmpty {
//                    filteredRestaurants = restaurants
//                } else {
//                    filteredRestaurants = restaurants.filter {
//                        $0.name.localizedCaseInsensitiveContains(query) ||
//                        $0.category.localizedCaseInsensitiveContains(query)
//                    }
//                }
//            }
//            
//            isLoading = false
//        }
//    }
//    
//    // MARK: - Управление подключением
//    
//    func retryConnection() {
//        print("🔄 Пытаемся переподключиться...")
//        
//        isLoading = true
//        errorMessage = nil
//        
//        Task {
//            let connected = await dataService.retryConnection()
//            
//            if connected {
//                print("✅ Успешно переподключились")
//                await loadRestaurants()
//            } else {
//                print("❌ Не удалось переподключиться")
//                errorMessage = "Не удалось подключиться к серверу"
//            }
//            
//            isLoading = false
//        }
//    }
//    
//    func refresh() {
//        print("🔄 Обновляем данные...")
//        loadRestaurants()
//    }
//    
//    // MARK: - Вспомогательные методы
//    
//    func getStats() -> String {
//        if restaurants.isEmpty {
//            return "Нет данных"
//        }
//        
//        let categories = Set(restaurants.map { $0.category })
//        let avgRating = restaurants.map { $0.rating }.reduce(0, +) / Double(restaurants.count)
//        
//        return "\(restaurants.count) ресторанов, \(categories.count) категорий, средний рейтинг: \(String(format: "%.1f", avgRating))"
//    }
//}
