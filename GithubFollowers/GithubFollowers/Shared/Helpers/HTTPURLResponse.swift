//
//  HTTPURLResponse.swift
//  GithubFollowers
//
//  Created by Chandra Welim on 15/06/25.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}

