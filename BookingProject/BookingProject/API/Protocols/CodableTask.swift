import Foundation

protocol CodableTask {
    func codableTask<T: Codable>(with url: URL, completion: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
