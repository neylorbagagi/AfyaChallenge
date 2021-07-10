//
//  ShowImageRequestResponse.swift
//  AfyaChallenge
//
//  Created by Neylor Bagagi on 08/07/21.
//  Copyright © 2021 Cyanu. All rights reserved.
//

import Foundation

// ACShowImage
struct ACShowImage:Codable {
    let id:Int
    let type:String
    let main:Bool
    let resolutions:ACShowImageResolutions
}

// ACShowImageResolutions
struct ACShowImageResolutions:Codable {
    let original:ACShowImageResolution
    let medium:ACShowImageResolution?
}

// ACShowImageResolution
struct ACShowImageResolution:Codable {
    let url:String
    let width:Int
    let height:Int
}
