//
//  Locking.swift
//  SkyUtils
//
//  Created by Skylar Schipper on 8/24/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

public protocol Locking {
    func lock()
    func unlock()
    func tryLock() -> Bool
}

public extension Locking {
    func sync<T>(_ block: (Void) throws -> (T)) rethrows -> T {
        self.lock()
        defer { self.unlock() }
        return try block()
    }
}
