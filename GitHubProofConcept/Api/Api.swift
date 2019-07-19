//
//  Repository.swift
//  GitHubProofConcept
//
//  Created by Developer on 18/7/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    
    static let BASE_URL_GITHUB = "https://api.github.com"
    static let ENDPOINT_USERS = "/users/"
    static let ENDPOINT_CONTRIBUTORS_EMBER = "/repos/emberjs/ember.js/contributors"
    static let LOGIN_GITHUB = "drvidal92"
    static let PASSWORD_GITHUB = "9vtGAL48EcJxwyq3"
    
    public static func getContributors() {
        Alamofire.request(BASE_URL_GITHUB + ENDPOINT_CONTRIBUTORS_EMBER).validate().responseJSON { response in
            switch response.result {
            case .success(_):
                if let data = response.data, let contributors = try? JSONDecoder().decode([Contributor].self, from: data) {
                    contributors.forEach({
                        getUserWith(contributor: $0)
                    })
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public static func getUserWith(contributor: Contributor) {
        let url = BASE_URL_GITHUB + ENDPOINT_USERS + contributor.login
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: getAuthHeaders()).validate().responseJSON { response in
            switch response.result {
            case .success(_):
                if let data = response.data, let contributorDetail = try? JSONDecoder().decode(Contributor.self, from: data) {
                    ContributorDAO.save(contributor: contributorDetail)
                }
            case .failure(let error):
                print(error.localizedDescription)
                ContributorDAO.save(contributor: contributor)
            }
        }
    }
    
    private static func getAuthHeaders() -> [String: String] {
        let credentialData = "\(LOGIN_GITHUB):\(PASSWORD_GITHUB)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        return headers
    }
    
}
