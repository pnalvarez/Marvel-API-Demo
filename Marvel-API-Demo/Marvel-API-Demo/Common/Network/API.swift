import Foundation

typealias Completion<T: Decodable> = (Result<T, APIError>) -> Void

enum APIError: Error {
    case fetchData
    case generic(description: String)
    case decode(description: String)
}

final class API<T: Decodable> {
    private let endpoint: APIEndpointExposable
    private let jsonDecoder: JSONDecoder
    private let urlSession: URLSession
    
    init(endpoint: APIEndpointExposable,
         jsonDecoder: JSONDecoder = JSONDecoder(),
         urlSession: URLSession = .shared) {
        self.endpoint = endpoint
        self.jsonDecoder = jsonDecoder
        self.urlSession = urlSession
    }
    
    func request<T>(completion: @escaping Completion<T>) -> URLSessionDataTask? {
        var requestModel = URLRequest(url: endpoint.baseURL)
        requestModel.httpMethod = endpoint.method.rawValue
        requestModel.httpBody = endpoint.body
        
        let task = urlSession.dataTask(with: requestModel) { (data, response, error) in
            if let error = error {
                completion(.failure(.generic(description: error.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(.fetchData))
                return
            }
            do {
                let decoded = try self.jsonDecoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                completion(.failure(.decode(description: error.localizedDescription)))
            }
        }
        task.resume()
        
        return task
    }
}
