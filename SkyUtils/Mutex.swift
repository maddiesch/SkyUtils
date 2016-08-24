//
//  Mutex.swift
//  SkyUtils
//
//  Created by Skylar Schipper on 8/24/16.
//  Copyright © 2016 Skylar Schipper. All rights reserved.
//

import Darwin.sys

public final class Mutex : Locking {
    public enum MutexType {
        case normal
        case recursive
    }

    private var backing = pthread_mutex_t()

    public init(mutexType: MutexType = .normal) {
        var attr = pthread_mutexattr_t()
        guard pthread_mutexattr_init(&attr) == 0 else {
            preconditionFailure("Failed to init mutex attribute")
        }

        switch mutexType {
        case .normal:
            pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL)
        case .recursive:
            pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        }

        guard pthread_mutex_init(&backing, &attr) == 0 else {
            preconditionFailure("Failed to init mutex")
        }
    }

    deinit {
        pthread_mutex_destroy(&backing)
    }

    public final func tryLock() -> Bool {
        return pthread_mutex_trylock(&backing) == 0
    }

    public final func lock() {
        pthread_mutex_lock(&backing)
    }

    public final func unlock() {
        pthread_mutex_unlock(&backing)
    }
}
