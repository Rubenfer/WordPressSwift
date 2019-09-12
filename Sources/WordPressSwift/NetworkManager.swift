import Foundation

internal class NetworkManager<Item> where Item: Decodable {
    
    private let request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
    
    func get(completion: @escaping (Item, HTTPURLResponse) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            do {
                let decodedData = try JSONDecoder().decode(Item.self, from: data)
                completion(decodedData, response)
            } catch { return }
        }.resume()
    }
    
}
