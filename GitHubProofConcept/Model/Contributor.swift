//
//  File.swift
//  GitHubProofConcept
//
//  Created by Developer on 18/7/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

struct Contributor: Codable {
    let login: String
    let avatar_url: String
    let name: String?
    let email: String?
}
