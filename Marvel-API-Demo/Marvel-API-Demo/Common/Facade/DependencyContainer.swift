import Foundation

protocol HasJSONDecoder {
    var jsonDecoder: JSONDecoder { get }
}

protocol HasMainQueue {
    var mainQueue: DispatchQueue { get }
}

protocol HasURLSession {
    var urlSession: URLSession { get}
}

protocol HasNoDependency { }

typealias Dependencies = HasJSONDecoder
                        & HasMainQueue
                        & HasURLSession
                        & HasNoDependency

final class DependencyContainer: Dependencies {
    lazy var jsonDecoder = JSONDecoder()
    lazy var mainQueue: DispatchQueue = .main
    lazy var urlSession: URLSession = .shared
}
