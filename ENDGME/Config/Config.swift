import Foundation

struct Config {
    static let supabaseURL: String = {
        guard let url = ProcessInfo.processInfo.environment["SUPABASE_URL"] else {
            fatalError("SUPABASE_URL not set in environment variables")
        }
        return url
    }()

    static let supabaseAnonKey: String = {
        guard let key = ProcessInfo.processInfo.environment["SUPABASE_ANON_KEY"] else {
            fatalError("SUPABASE_ANON_KEY not set in environment variables")
        }
        return key
    }()
}
