import UIKit

class MediaAPIClient {
    
    static func search(for query: String, completion: @escaping (Response) -> Void) {
        let urlConstructor = URLConstructor(searchTerm: query)
        guard let url = urlConstructor.build(searchTerm: urlConstructor.searchTerm) else { return }
        URLSession(configuration: .ephemeral).dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completion(.failed(error))
            } else {
                do {
                    let responseObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    DispatchQueue.main.async {
                        completion(.success(responseObject!))
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    
}
