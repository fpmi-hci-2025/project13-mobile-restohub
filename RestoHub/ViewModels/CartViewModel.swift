import Foundation
import SwiftUI
internal import Combine

class CartViewModel: ObservableObject {
    // Структура для группировки по ресторанам
    struct RestaurantCart {
        let restaurantId: String
        let restaurantName: String
        var items: [CartItem]
        var total: Double {
            items.reduce(0) { $0 + $1.totalPrice }
        }
        var itemCount: Int {
            items.reduce(0) { $0 + $1.quantity }
        }
    }
    
    @Published var restaurantCarts: [String: RestaurantCart] = [:] // Группировка по ID ресторана
    @Published var totalPrice: Double = 0.0
    @Published var isLoading = false
    
    var cartItems: [CartItem] {
        restaurantCarts.values.flatMap { $0.items }
    }
    
    var itemCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
    
    var sortedRestaurants: [RestaurantCart] {
        Array(restaurantCarts.values).sorted { $0.restaurantName < $1.restaurantName }
    }
    
    func addItem(_ menuItem: MenuItem, restaurantId: String, restaurantName: String, quantity: Int = 1, instructions: String = "") {
        // Проверяем, есть ли уже корзина для этого ресторана
        if var restaurantCart = restaurantCarts[restaurantId] {
            // Проверяем, есть ли уже такой товар в корзине ресторана
            if let index = restaurantCart.items.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
                restaurantCart.items[index].quantity += quantity
            } else {
                let newItem = CartItem(
                    id: UUID().uuidString,
                    menuItem: menuItem,
                    restaurantId: restaurantId,
                    restaurantName: restaurantName,
                    price: menuItem.price,
                    quantity: quantity,
                    specialInstructions: instructions
                )
                restaurantCart.items.append(newItem)
            }
            restaurantCarts[restaurantId] = restaurantCart
        } else {
            // Создаем новую корзину для ресторана
            let newItem = CartItem(
                id: UUID().uuidString,
                menuItem: menuItem,
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                price: menuItem.price,
                quantity: quantity,
                specialInstructions: instructions
            )
            
            let newRestaurantCart = RestaurantCart(
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                items: [newItem]
            )
            restaurantCarts[restaurantId] = newRestaurantCart
        }
        updateTotal()
    }
    
    func removeItem(_ item: CartItem) {
        if var restaurantCart = restaurantCarts[item.restaurantId] {
            restaurantCart.items.removeAll { $0.id == item.id }
            
            // Если после удаления товаров в корзине ресторана не осталось, удаляем корзину ресторана
            if restaurantCart.items.isEmpty {
                restaurantCarts.removeValue(forKey: item.restaurantId)
            } else {
                restaurantCarts[item.restaurantId] = restaurantCart
            }
        }
        updateTotal()
    }
    
    func updateQuantity(for item: CartItem, newQuantity: Int) {
        guard var restaurantCart = restaurantCarts[item.restaurantId] else { return }
        
        if let index = restaurantCart.items.firstIndex(where: { $0.id == item.id }) {
            if newQuantity > 0 {
                restaurantCart.items[index].quantity = newQuantity
            } else {
                restaurantCart.items.remove(at: index)
                
                // Если после удаления товаров в корзине ресторана не осталось, удаляем корзину ресторана
                if restaurantCart.items.isEmpty {
                    restaurantCarts.removeValue(forKey: item.restaurantId)
                    updateTotal()
                    return
                }
            }
            restaurantCarts[item.restaurantId] = restaurantCart
        }
        updateTotal()
    }
    
    func clearRestaurantCart(restaurantId: String) {
        restaurantCarts.removeValue(forKey: restaurantId)
        updateTotal()
    }
    
    func clearCart() {
        restaurantCarts.removeAll()
        updateTotal()
    }
    
    func getItemsForRestaurant(_ restaurantId: String) -> [CartItem] {
        return restaurantCarts[restaurantId]?.items ?? []
    }
    
    func getTotalForRestaurant(_ restaurantId: String) -> Double {
        return restaurantCarts[restaurantId]?.total ?? 0.0
    }
    
    private func updateTotal() {
        totalPrice = restaurantCarts.values.reduce(0) { $0 + $1.total }
    }
}
