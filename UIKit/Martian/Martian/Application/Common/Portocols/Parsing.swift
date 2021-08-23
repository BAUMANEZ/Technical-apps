//
//  Parsing.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

enum APIError: Error {
    case wrongURL
    case roverNotFound
    case parsingFailure
}

protocol ParsingProtocol {
    func parsePhotos(for date: Date, completion: @escaping (Result<PhotoArray, APIError>) -> ())
    func parseRovers(completion: @escaping (Result<RoversList, APIError>) -> ())
}
