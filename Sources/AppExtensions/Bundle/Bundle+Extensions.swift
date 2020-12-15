//
//  Bundle+Extensions.swift
//  
//
//  Created by Rodrigo Cian Berrios on 19/11/2020.
//

import Foundation

public extension Bundle {
    
    static var bundleID : String? {
        return self.main.bundleIdentifier
    }
    
    // MARK: - App and Build Info
    
    static var appName: String? {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        
        return nil
    }
    
    static var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    
    static var build: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    static var versionAndBuild: String? {
        if version != nil && build != nil {
            if version == build {
                return "v\(version!)"
            } else {
                return "v\(version!)(\(build!))"
            }
        }
        return nil
    }
}

