import Foundation

protocol APIEndpointExposable {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String]? { get }
    var body: Data? { get }
    var absoluteStringURL: String { get }
}
