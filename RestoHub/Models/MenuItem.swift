// Models/MenuItem.swift
struct MenuItem: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let imageUrl: String
    let category: String
    let restaurantId: String
    let isAvailable: Bool
}
