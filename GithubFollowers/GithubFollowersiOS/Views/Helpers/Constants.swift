//
//  Constants.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 15/06/25.
//

import UIKit

enum SFSymbols {
    static let location     = UIImage(systemName: "mappin.and.ellipse")
    static let repos        = UIImage(systemName: "folder")
    static let gists        = UIImage(systemName: "text.alignleft")
    static let followers    = UIImage(systemName: "person.2")
    static let following    = UIImage(systemName: "person")
    static let repository   = UIImage(systemName: "book.closed")
    static let code         = UIImage(systemName: "chevron.left.slash.chevron.right")
}

private class BundleLocator {}

enum Images {
    static let bundle = Bundle(for: BundleLocator.self)
    
    static let ghLogo = UIImage(named: "gh-logo", in: bundle, compatibleWith: nil)
    static let placeholder = UIImage(named: "avatar-placeholder", in: bundle, compatibleWith: nil)
    static let emptyState = UIImage(named: "empty-state-logo", in: bundle, compatibleWith: nil)
}


enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}


