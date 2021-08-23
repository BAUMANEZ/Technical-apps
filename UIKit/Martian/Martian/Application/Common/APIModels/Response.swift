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

struct Rover: Decodable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: UInt
    let maxDate: String
    let totalPhotos: UInt
    //let cameras: [Camera]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        //case cameras
    }
}

struct Camera: Decodable {
    let id: UUID
    let name: String
    let roverID: UUID
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

struct Photo: Decodable {
    let id: UUID
    let sol: UInt
    let camera: Camera
    let imageSource: String
    let earthDate: Date
    let rover: Rover
    
    private enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case imageSource = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}
