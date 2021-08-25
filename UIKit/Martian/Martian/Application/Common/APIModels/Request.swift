//
//  Request.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit
import Alamofire

class APIRequest {
    private static let APIKey = "Jk0SRQy1JsFuiZYrJhUKbEACiaQ9UvZj051uosQn" 
        //"thJZ9IHrinJFa6GVjDunDRMMerozdsRXkpEffxch"
    private(set) var latestParsedModel: Decodable?
    static var shared: ParsingProtocol = APIRequest()
    
    public init() {}
}

//MARK: - Parsing functions
extension APIRequest: ParsingProtocol {
    
    func get(rover: String?) -> Rover? {
        return nil
    }
    
    func parseRovers(completion: @escaping (Result<RoversList, APIError>) -> ()) {
        switch makeRoversListURL() {
        case .success(let url):
            AF.request(url).validate().responseDecodable(of: RoversList.self) { [weak self] respone in
                guard
                    let self = self,
                    let parsedData = respone.value
                else {
                    completion(.failure(.parsingFailure))
                    return
                }
                self.latestParsedModel = parsedData
                completion(.success(parsedData))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func parsePhotos(for date: Date, completion: @escaping (Result<PhotosList, APIError>) -> ()) {
        switch makeRoverPhotosURL(for: date) {
        case .success(let url):
            AF.request(url).validate().responseDecodable(of: PhotosList.self) { respone in
                guard
                    let parsedData = respone.value
                else {
                    completion(.failure(.parsingFailure))
                    return
                }
                completion(.success(parsedData))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

//MARK: - Helpers
extension APIRequest {
    
    //Gets date from user input and saved chosen rover then forms the URL
    private func makeRoverPhotosURL(for date: Date) -> Result<URL, APIError> {
        let formattedDate = DateFormatter().string(from: date, format: "yyyy-MM-dd")
        guard let chosenRover = UserDefaults.standard.string(forKey: "chosen rover") else {
            return .failure(.roverNotFound)
        }
        let photosURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(chosenRover)/photos?earth_date=\(formattedDate)&api_key=\(APIRequest.APIKey)"
        return makeURL(string: photosURL)
    }
    
    private func makeRoversListURL() -> Result<URL, APIError> {
        let roversURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/?api_key=\(APIRequest.APIKey)"
        return makeURL(string: roversURL)
    }
    
    private func makeURL(string: String) -> Result<URL, APIError> {
        guard let url = URL(string: string) else {
            return .failure(.wrongURL)
        }
        
        return .success(url)
    }
}
