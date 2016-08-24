//
//  ErrorBuilder.swift
//  SkyUtils
//
//  Created by Skylar Schipper on 8/24/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import Foundation

public protocol ErrorBuilder {
    var rawValue: Int { get }
    func error(forDomain domain: String, withReason reason: String?, recoveryOptions recovery: String?) -> Error
}

public extension ErrorBuilder {
    func error(forDomain domain: String, withReason reason: String? = nil, recoveryOptions recovery: String? = nil) -> Error {
        var info: [AnyHashable: Any] = [:]
        if let r = reason {
            info[NSLocalizedDescriptionKey] = r
        }
        if let r = recovery {
            info[NSLocalizedRecoveryOptionsErrorKey] = r
        }
        return NSError(domain: domain, code: self.rawValue, userInfo: info)
    }
}
