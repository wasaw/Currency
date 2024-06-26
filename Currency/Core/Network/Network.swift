//
//  Network.swift
//  Currency
//
//

import Foundation

final class Network: NetworkServiceProtocol {
    
// MARK: - Properties
    
    private let session = URLSession(configuration: .default)
    private let decoder: JSONDecoder
    private let userDefault: UserDefaults
    
// MARK: - Lifecycle
    
    init() {
        self.decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        userDefault = UserDefaults.standard
    }
}

// MARK: - Public API

extension Network {
// MARK: - Helpers
    
    func loadData(request: URLRequest, completion: @escaping(Result<CurrencyDataModel, Error>) -> Void) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let urlResponse = response as? HTTPURLResponse,
                  (200...299).contains(urlResponse.statusCode) else {
                return
            }

            if let data = data {
                do {
                    guard let welcome = try? JSONDecoder().decode(CurrencyDataModel.self, from: data) else { return }
                    
                    completion(.success(welcome))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
