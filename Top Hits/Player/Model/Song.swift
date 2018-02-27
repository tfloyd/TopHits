//
//  Song.swift
//  Top Hits
//
//  Created by Jeff Tabios on 26/02/2018.
//  Copyright © 2018 Jeff Tabios. All rights reserved.
//

import Foundation

struct Song: Decodable {
    let author : Author?
    let createdOn : String?
    let modifiedOn : String?
    let picture : Picture?
    let audioLink : URL?
    let id : String?
    let name : String?
}
