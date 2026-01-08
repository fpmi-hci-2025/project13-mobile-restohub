import Foundation

struct Constants {
    struct Database {
        static let host = "localhost"
        static let port = 5432
        static let databaseName = "RestoHub"
        static let username = "dashaignatenko"
        // Пароль будем брать из Keychain или переменных окружения
    }
    
    struct API {
        static let baseURL = "http://localhost:3000"
    }
}
