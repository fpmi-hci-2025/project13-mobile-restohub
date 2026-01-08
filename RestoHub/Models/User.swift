// Models/User.swift
struct User: Codable, Identifiable {
    let id: String
    let firstName: String
    let lastName: String
    let nickname: String
    let email: String?
    let phone: String?
    let address: String?
    let profileImageUrl: String?
}
