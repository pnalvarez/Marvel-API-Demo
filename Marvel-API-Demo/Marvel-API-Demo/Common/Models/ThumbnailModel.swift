//
//  ThumbnailModel.swift
//  Marvel-API-Demo
//
//  Created by Pedro Alvarez on 14/11/21.
//

struct ThumbnailModel: Decodable {
    let path: String
    let imageExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
