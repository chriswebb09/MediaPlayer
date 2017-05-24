import Foundation

protocol URLInjectable { }

enum EndPoint: String {
    case base, search
}

struct URLInjector {
    static var endpointUrl: (EndPoint) -> URL = {
        endpoint in
        switch endpoint {
        case .base :
            return URL(string: URLRouter.base.url)!
        case .search :
            return URL(string: URLRouter.base.url + URLRouter.path.url)!
        }
    }
}

struct URLConstructor {
    
    var searchTerm: String = "" 
    
    func build(searchTerm: String) -> URL? {
        let encodedQuery = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlString = URLRouter.base.url + URLRouter.path.url + encodedQuery
        return URL(string: urlString)
    }
}
