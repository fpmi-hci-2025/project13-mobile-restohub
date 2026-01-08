import SwiftUI
internal import Combine

class UserViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isLoading = false
    
    struct User {
        let id: String
        let firstName: String
        let lastName: String
        let nickname: String
        let email: String?
        let phone: String?
    }
    
//    init() {
//        checkAuthentication()
//    }
    
    func signUp(firstName: String, lastName: String, nickname: String, email: String? = nil, phone: String? = nil, password: String) {
        guard email != nil && !(email?.isEmpty ?? true) ||
              phone != nil && !(phone?.isEmpty ?? true) else {
            print("Ошибка: нужно указать email или телефон")
            return
        }
        
        let user = User(
            id: UUID().uuidString,
            firstName: firstName,
            lastName: lastName,
            nickname: nickname,
            email: email,
            phone: phone
        )
        
        currentUser = user
        isAuthenticated = true
        
        UserDefaults.standard.set(true, forKey: "isAuthenticated")
        
        if let email = email, !email.isEmpty {
            UserDefaults.standard.set(email, forKey: "userEmail")
            UserDefaults.standard.set(nil, forKey: "userPhone")
        } else if let phone = phone, !phone.isEmpty {
            UserDefaults.standard.set(phone, forKey: "userPhone")
            UserDefaults.standard.set(nil, forKey: "userEmail")
        }
        
        UserDefaults.standard.set(firstName, forKey: "userFirstName")
        UserDefaults.standard.set(lastName, forKey: "userLastName")
        UserDefaults.standard.set(nickname, forKey: "userNickname")
        
        print("Регистрация успешна для пользователя: \(nickname)")
    }
    
    func signIn(email: String, password: String) {
        let user = User(
            id: UUID().uuidString,
            firstName: "John",
            lastName: "Doe",
            nickname: "restofan",
            email: email,
            phone: nil
        )
        
        currentUser = user
        isAuthenticated = true
        
        UserDefaults.standard.set(true, forKey: "isAuthenticated")
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set("John", forKey: "userFirstName")
        UserDefaults.standard.set("Doe", forKey: "userLastName")
        UserDefaults.standard.set("restofan", forKey: "userNickname")
        
        print("Вход успешен для пользователя: \(email)")
    }
    
    func signIn(phone: String, password: String) {
        let user = User(
            id: UUID().uuidString,
            firstName: "John",
            lastName: "Doe",
            nickname: "restofan",
            email: nil,
            phone: phone
        )
        
        currentUser = user
        isAuthenticated = true
        
        UserDefaults.standard.set(true, forKey: "isAuthenticated")
        UserDefaults.standard.set(phone, forKey: "userPhone")
        UserDefaults.standard.set("John", forKey: "userFirstName")
        UserDefaults.standard.set("Doe", forKey: "userLastName")
        UserDefaults.standard.set("restofan", forKey: "userNickname")
        
        print("Вход успешен для телефона: \(phone)")
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
        
        UserDefaults.standard.removeObject(forKey: "isAuthenticated")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userPhone")
        UserDefaults.standard.removeObject(forKey: "userFirstName")
        UserDefaults.standard.removeObject(forKey: "userLastName")
        UserDefaults.standard.removeObject(forKey: "userNickname")
        
        print("Пользователь вышел")
    }
    
    private func checkAuthentication() {
        let isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        self.isAuthenticated = isAuthenticated
        
        if isAuthenticated {
            let email = UserDefaults.standard.string(forKey: "userEmail")
            let phone = UserDefaults.standard.string(forKey: "userPhone")
            let firstName = UserDefaults.standard.string(forKey: "userFirstName") ?? "John"
            let lastName = UserDefaults.standard.string(forKey: "userLastName") ?? "Doe"
            let nickname = UserDefaults.standard.string(forKey: "userNickname") ?? "restofan"
            
            currentUser = User(
                id: UUID().uuidString,
                firstName: firstName,
                lastName: lastName,
                nickname: nickname,
                email: email,
                phone: phone
            )
            
            print("Пользователь восстановлен: \(nickname)")
        }
    }
    
    var hasPaymentMethods: Bool {
        return false
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isPhoneValid(_ phone: String) -> Bool {
        let digits = phone.filter { $0.isNumber }
        return digits.count >= 9
    }
}
