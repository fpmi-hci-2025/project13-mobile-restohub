import Foundation

struct PostgreSQLConfig {
    static let shared = PostgreSQLConfig()
    
    let host: String
    let port: Int
    let username: String
    let password: String
    let database: String
    
    private init() {
        // Получаем настройки из Info.plist или переменных окружения
        host = Bundle.main.object(forInfoDictionaryKey: "DB_HOST") as? String ?? "localhost"
        port = Int(Bundle.main.object(forInfoDictionaryKey: "DB_PORT") as? String ?? "5432") ?? 5432
        username = Bundle.main.object(forInfoDictionaryKey: "DB_USERNAME") as? String ?? "dashaignatenko"
        password = Bundle.main.object(forInfoDictionaryKey: "DB_PASSWORD") as? String ?? ""
        database = Bundle.main.object(forInfoDictionaryKey: "DB_NAME") as? String ?? "RestoHub"
    }
    
    var connectionString: String {
        return "postgresql://\(username):\(password)@\(host):\(port)/\(database)"
    }
    
    func printConfig() {
        print("📊 PostgreSQL Configuration:")
        print("  Host: \(host)")
        print("  Port: \(port)")
        print("  Database: \(database)")
        print("  Username: \(username)")
    }
}
