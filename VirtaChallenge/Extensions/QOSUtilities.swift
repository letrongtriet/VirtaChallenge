//
//  QOSUtilities.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//


import Foundation

public func runOnBackGround(qos: DispatchQoS.QoSClass = .utility, task: @escaping () -> Void) {
    if qos.isCurrent {
        task()
    } else {
        DispatchQueue.global(qos: qos).async(execute: task)
    }
}

public func runOnBackGround(qos: DispatchQoS.QoSClass = .utility, after: TimeInterval, task: @escaping () -> Void) {

    DispatchQueue.global(qos: qos).asyncAfter(deadline: .now() + after, execute: task)
}

/// Executing task on main thread
public func runOnMainThread(task: @escaping () -> Void) {
    if Thread.isMainThread {
        task()
    } else {
        DispatchQueue.main.async(execute: task)
    }
}

/// Excuting task on main thread after x seconds
public func runOnMainThread(after: TimeInterval, task: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: task)
}

extension DispatchQoS.QoSClass {
    var isCurrent: Bool {
        var qosClass: DispatchQoS.QoSClass?

        switch Thread.current.qualityOfService {
        case .background:
            qosClass = .background
        case .default:
            qosClass = .default
        case .userInitiated:
            qosClass = .userInitiated
        case .userInteractive:
            qosClass = .userInteractive
        case .utility:
            qosClass = .utility
        @unknown default:
            break
        }

        return self == qosClass
    }
}
