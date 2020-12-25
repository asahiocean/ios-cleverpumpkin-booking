import Foundation

protocol CodableTask {
    func codableTask<T: Codable>(with url: URL, completion: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: CodableTask {
    public func codableTask<T: Codable>(with url: URL, completion: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, response, error)
                return
            }
            completion(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
}
