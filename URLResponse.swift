//
//  URLResponse.swift
//  SkyUtils
//
//  Created by Skylar Schipper on 8/24/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import Foundation

public extension URLResponse {
    public var httpResponse: HTTPURLResponse? {
        return self as? HTTPURLResponse
    }
}

public extension HTTPURLResponse {
    public var isOK: Bool {
        return (200..<300).contains(self.statusCode)
    }

    func checkOK() throws  {
        guard !self.isOK else {
            return
        }
        let status = self.statusCode
        let url = self.url
        let headers = self.allHeaderFields
        throw HTTPError(status, url, headers)
    }
}

public struct HTTPError : Error {
    public let statusCode: Int
    public let url: URL?
    public let headers: [AnyHashable: Any]

    internal init(_ statusCode: Int, _ url: URL?, _ headers: [AnyHashable: Any]) {
        self.statusCode = statusCode
        self.url = url
        self.headers = headers
    }
}
