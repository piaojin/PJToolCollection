//
//  RunLoopManager.swift
//  RunLoopInSwift
//
//  Created by Zoey Weng on 2018/6/25.
//  Copyright © 2018年 piaojin. All rights reserved.
//

import UIKit

open class RunLoopManager: NSObject {
    open static func addRunLoopObserver(runLoop: CFRunLoop = CFRunLoopGetCurrent(), runLoopModel: CFRunLoopMode = .defaultMode, _ repeats: Bool = true, observerClosure: @escaping (CFRunLoopObserver?, CFRunLoopActivity) -> Void) {
        do {
            let observer = try createRunloopObserver(repeats, observerClosure: observerClosure)
            CFRunLoopAddObserver(runLoop, observer, runLoopModel)
        } catch {
            print("runloop 观察者创建失败")
        }
    }
    
    private static func createRunloopObserver(_ repeats: Bool = true, observerClosure: @escaping (CFRunLoopObserver?, CFRunLoopActivity) -> Void) throws -> CFRunLoopObserver? {
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, repeats, 0, observerClosure)
        return observer
    }
}
