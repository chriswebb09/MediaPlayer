import Foundation

protocol CreateAccountDelegate: class {
    func createAcccount(with username: String, email: String, password: String)
}
