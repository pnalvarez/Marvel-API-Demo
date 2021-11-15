import Foundation

typealias Completion<T: Decodable> = (Result<T, APIError>) -> Void

enum APIError: Error {
    case invalidURL
    case fetchData
    case generic(description: String)
    case decode(description: String)
}

final class API<T: Decodable> {
    typealias Dependencies = HasJSONDecoder & HasURLSession
    
    private let dependencies: Dependencies
    private let endpoint: APIEndpointExposable
    
    private let basePath = "https://gateway.marvel.com/v1/public"
    private let apiKey = "5d270d6ba90b8e7de71d2a65b6cce967&hash=1eb2d8a190e62c0ecf934462a91eb071"
    
    init(endpoint: APIEndpointExposable,
         dependencies: Dependencies = DependencyContainer()) {
        self.endpoint = endpoint
        self.dependencies = dependencies
    }
    
    @discardableResult
    func request<T>(completion: @escaping Completion<T>) -> URLSessionDataTask? {
        let baseURL = basePath + endpoint.path + "?ts=1&apikey=\(apiKey)" + (makeExtraHeaders() ?? "")
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return nil
        }
        var requestModel = URLRequest(url: url)
        requestModel.httpMethod = endpoint.method.rawValue
        requestModel.httpBody = endpoint.body
        
        let task = dependencies.urlSession.dataTask(with: requestModel) { (data, response, error) in
            if let error = error {
                completion(.failure(.generic(description: error.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(.fetchData))
                return
            }
            do {
                let decoded = try self.dependencies.jsonDecoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                completion(.failure(.decode(description: error.localizedDescription)))
            }
        }
        task.resume()
        
        return task
    }
    
    private func makeExtraHeaders() -> String? {
        var headerString = ""
        guard let headers = endpoint.headers else {
            return nil
        }
        for (key, value) in headers {
            headerString += "&\(key)=\(value)"
        }
        return headerString
    }
}
