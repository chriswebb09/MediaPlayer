import Foundation

class DataService: ServiceProtocol {
    var tracks: [Track] = []
}

class NetworkService: ServiceProtocol {
    
    var provider: MediaAPIClient
    
    init(provider: MediaAPIClient) {
        self.provider = provider
    }
}

