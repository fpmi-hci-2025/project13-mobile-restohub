import Foundation
import PostgresNIO

protocol PostgresRowDecodable {
    init?(row: PostgresRow)
}

struct PostgresRowDecoder {
    static func decode<T: PostgresRowDecodable>(_ rows: [PostgresRow]) -> [T] {
        return rows.compactMap { T(row: $0) }
    }
}
