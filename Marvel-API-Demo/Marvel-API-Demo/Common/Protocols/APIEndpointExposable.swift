import Foundation

protocol APIEndpointExposable {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String]? { get }
    var body: Data? { get }
}
