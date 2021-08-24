//
//  Response.swift
//  Martian
//
//  Created by Арсений Токарев on 23.08.2021.
//

import UIKit

struct RoversList: Decodable {
    let rovers: [Rover]
}

struct PhotosList: Decodable {
    let photos: [Photo]
}

struct Rover: Decodable {
    let id: Int
    let name: String
    //let landingDate: String
    //let launchDate: String
    //let status: String
    let maxSol: Int
    let maxDate: String
    //let totalPhotos: Int
    let cameras: [Camera]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        //case landingDate = "landing_date"
        //case launchDate = "launch_date"
        //case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        //case totalPhotos = "total_photos"
        case cameras
    }
}

struct Camera: Decodable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

struct Photo: Decodable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imageSource: String
    //let earthDate: String
    //let rover: Rover
    
    private enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case imageSource = "img_src"
        //case earthDate = "earth_date"
        //case rover
    }
}
