//
//  Request.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit
import Alamofire

typealias RoverArray = [Rover]
typealias PhotoArray = [Photo]

class APIRequest {
    private static let APIKey = "thJZ9IHrinJFa6GVjDunDRMMerozdsRXkpEffxch"
    static var shared: ParsingProtocol = APIRequest()
    
    public init() {}
}

//MARK: - Parsing functions
extension APIRequest: ParsingProtocol {
    
    func parseRovers(completion: @escaping (Result<RoversList, APIError>) -> ()) {
        switch makeRoversListURL() {
        case .success(let url):
            AF.request(url).validate().responseDecodable(of: RoversList.self) { respone in
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
    
    func parsePhotos(for date: Date, completion: @escaping (Result<PhotoArray, APIError>) -> ()) {
        switch makeRoverPhotosURL(for: date) {
        case .success(let url):
            AF.request(url).validate().responseDecodable(of: PhotoArray.self) { respone in
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
        let formattedDate = dateToString(date)
        guard let chosenRover = UserDefaults.standard.string(forKey: "chosen rover") else {
            return .failure(.roverNotFound)
        }
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(chosenRover)/photos?earth_date=\(formattedDate)&api_key=\(APIRequest.APIKey)"
        return makeURL(string: urlString)
    }
    
    private func makeRoversListURL() -> Result<URL, APIError> {
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/?api_key=\(APIRequest.APIKey)"
        return makeURL(string: urlString)
    }
    
    private func makeURL(string: String) -> Result<URL, APIError> {
        guard let url = URL(string: string) else {
            return .failure(.wrongURL)
        }
        
        return .success(url)
    }
    
    //Simple date formatting
    private func dateToString(_ date: Date = Date()) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter.string(from: date)
    }
}
