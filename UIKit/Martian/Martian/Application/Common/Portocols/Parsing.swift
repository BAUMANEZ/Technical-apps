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
    var latestParsedModel: Decodable? { get }
    
    func get(rover: String?) -> Rover?
    func parsePhotos(for date: Date, completion: @escaping (Result<PhotosList, APIError>) -> ())
    func parseRovers(completion: @escaping (Result<RoversList, APIError>) -> ())
}
