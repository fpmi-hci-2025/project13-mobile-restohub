import Foundation
import SwiftUI
internal import Combine

class OrdersViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var isLoading = false
    
    func fetchOrders(userId: String) {
        isLoading = true
        // Здесь будет вызов API для получения заказов
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.orders = self.mockOrders()
            self.isLoading = false
        }
    }
    
    func getOrderStatusText(_ status: Order.OrderStatus) -> String {
        switch status {
        case .pending: return "Ожидание подтверждения"
        case .confirmed: return "Подтверждено"
        case .preparing: return "Готовится"
        case .onTheWay: return "В пути"
        case .delivered: return "Доставлено"
        case .cancelled: return "Отменено"
        }
    }
    
    func getStatusColor(_ status: Order.OrderStatus) -> Color {
        switch status {
        case .pending: return .yellow
        case .confirmed: return .blue
        case .preparing: return .orange
        case .onTheWay: return .purple
        case .delivered: return .green
        case .cancelled: return .red
        }
    }
    
    private func mockOrders() -> [Order] {
        // Возвращаем тестовые данные
        return []
    }
}
