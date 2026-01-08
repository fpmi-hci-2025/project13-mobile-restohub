import Foundation
internal import Combine

class RestaurantDataService {
    static let shared = RestaurantDataService()
    
    private let postgresService = PostgreSQLService.shared
    @Published private(set) var isConnected = false
    @Published private(set) var connectionStatus = "Проверка подключения..."
    
    private var connectionCheckTask: Task<Void, Never>?
    
    private init() {
        startConnectionMonitoring()
    }
    
    // MARK: - Мониторинг подключения
    
    private func startConnectionMonitoring() {
        connectionCheckTask = Task {
            while !Task.isCancelled {
                await checkConnection()
                // Проверяем каждые 30 секунд
                try? await Task.sleep(nanoseconds: 30_000_000_000)
            }
        }
    }
    
    private func checkConnection() async {
        let connected = await postgresService.checkConnection()
        
        await MainActor.run {
            self.isConnected = connected
            self.connectionStatus = connected ? "✅ Подключено к PostgreSQL" : "⚠️ Используются тестовые данные"
        }
    }
    
    // MARK: - Основные методы
    
    func fetchRestaurants() async throws -> [Restaurant] {
        print("📥 Загрузка ресторанов...")
        
        if isConnected {
            do {
                print("🌐 Используем реальную БД")
                let restaurants = try await postgresService.fetchAllRestaurants()
                print("✅ Загружено \(restaurants.count) ресторанов из PostgreSQL")
                return restaurants
                
            } catch {
                print("❌ Ошибка загрузки из PostgreSQL: \(error)")
                await MainActor.run {
                    self.isConnected = false
                    self.connectionStatus = "⚠️ Ошибка загрузки, используем тестовые данные"
                }
                throw error
            }
        } else {
            print("📱 Используем тестовые данные")
            let mockRestaurants = postgresService.getMockRestaurants()
            print("✅ Загружено \(mockRestaurants.count) тестовых ресторанов")
            return mockRestaurants
        }
    }
    
    func filterRestaurants(by category: String) async throws -> [Restaurant] {
        if category == "All" {
            return try await fetchRestaurants()
        }
        
        if isConnected {
            do {
                return try await postgresService.fetchRestaurantsByCategory(category)
            } catch {
                print("❌ Ошибка фильтрации в PostgreSQL: \(error)")
                // Fallback: фильтруем локально
                let all = try await fetchRestaurants()
                return all.filter { $0.category == category }
            }
        } else {
            let all = postgresService.getMockRestaurants()
            return all.filter { $0.category == category }
        }
    }
    
    func searchRestaurants(query: String) async throws -> [Restaurant] {
        if query.isEmpty {
            return try await fetchRestaurants()
        }
        
        if isConnected {
            do {
                return try await postgresService.searchRestaurants(query: query)
            } catch {
                print("❌ Ошибка поиска в PostgreSQL: \(error)")
                // Fallback: ищем локально
                let all = try await fetchRestaurants()
                return all.filter {
                    $0.name.localizedCaseInsensitiveContains(query) ||
                    $0.category.localizedCaseInsensitiveContains(query)
                }
            }
        } else {
            let all = postgresService.getMockRestaurants()
            return all.filter {
                $0.name.localizedCaseInsensitiveContains(query) ||
                $0.category.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    // MARK: - Управление подключением
    
    func retryConnection() async -> Bool {
        print("🔄 Повторная попытка подключения...")
        
        let connected = await postgresService.checkConnection()
        
        await MainActor.run {
            self.isConnected = connected
            self.connectionStatus = connected ? "✅ Подключено к PostgreSQL" : "⚠️ Используются тестовые данные"
        }
        
        return connected
    }
    
    func getConnectionStatus() -> String {
        return connectionStatus
    }
    
    // MARK: - Отмена задач
    
    deinit {
        connectionCheckTask?.cancel()
    }
}
