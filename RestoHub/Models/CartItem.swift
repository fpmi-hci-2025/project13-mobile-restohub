// Models/CartItem.swift
struct CartItem: Identifiable, Codable {
    let id: String
    let menuItem: MenuItem
    let restaurantId: String // Добавляем ID ресторана
    let restaurantName: String // Добавляем название ресторана
    let price: Double
    var quantity: Int
    var specialInstructions: String
    
    var totalPrice: Double {
        menuItem.price * Double(quantity)
    }
}
