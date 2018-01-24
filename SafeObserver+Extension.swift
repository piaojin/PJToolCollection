//
//  SafeObserver+Extension.swift
//  Swifter
//
//  Created by Zoey Weng on 2018/1/24.
//  Copyright © 2018年 Zoey Weng. All rights reserved.
//

import Foundation

extension NSObject {
    private struct AssociatedKeys {
        static var safeObservers = "safeObservers"
    }
    
    private var safeObservers: [ObserverInfo] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.safeObservers) as? [ObserverInfo] ?? []
        }
        set (new) {
            objc_setAssociatedObject(self, &AssociatedKeys.safeObservers, new, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addSafeObserver(observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions) {
        let observerInfo = ObserverInfo(observer: observer, keypath: keyPath)
        if !self.safeObservers.contains(observerInfo) {
            self.safeObservers.append(ObserverInfo(observer: observer, keypath: keyPath))
            self.addObserver(observer, forKeyPath: keyPath, options: options, context: nil)
        }
    }
    
    func removeSafeObserver(observer: NSObject, forKeyPath keyPath: String) {
        let observerInfo = ObserverInfo(observer: observer, keypath: keyPath)
        if self.safeObservers.contains(observerInfo) {
            if let index = self.safeObservers.index(of: observerInfo) {
                self.safeObservers.remove(at: index)
                self.removeObserver(observer, forKeyPath: keyPath)
            }
        }
    }
}

private class ObserverInfo: Equatable {
    let observer: UnsafeMutableRawPointer
    let keypath: String
    
    init(observer: NSObject, keypath: String) {
        self.observer = Unmanaged.passUnretained(observer).toOpaque()
        self.keypath = keypath
    }
}

private func ==(lhs: ObserverInfo, rhs: ObserverInfo) -> Bool {
    return lhs.observer == rhs.observer && lhs.keypath == rhs.keypath
}
