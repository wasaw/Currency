//
//  NetworkService.swift
//  Currency
//
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func loadData(request: URLRequest, completion: @escaping(Result<CurrencyDataModel, Error>) -> Void)
}
