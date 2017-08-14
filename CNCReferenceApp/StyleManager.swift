//
//  StyleManager.swift
//
//  Created by Seyhun Akyürek on 16/10/2016.
//  Copyright © 2016 seyhunak. All rights reserved.
//
import Foundation
import ChameleonFramework

typealias Style = StyleManager

//MARK: - StyleManager
final class StyleManager {
    
    // MARK: - StyleManager
    
    static func setUpTheme() {
        Chameleon.setGlobalThemeUsingPrimaryColor(primaryTheme(), withSecondaryColor: theme(), usingFontName: font(), andContentStyle: content())
        UIButton.appearance(whenContainedInInstancesOf: [UITableView.self]).backgroundColor = UIColor.clear
        
    }
    
    // MARK: - Theme
    
    static func primaryTheme() -> UIColor {
        return FlatNavyBlue()
    }
    
    static func theme() -> UIColor {
        return FlatSkyBlue()
    }
    
    static func toolBarTheme() -> UIColor {
        return FlatMint()
    }
    
    static func tintTheme() -> UIColor {
        return FlatMint()
    }
    
    static func titleTextTheme() -> UIColor {
        return FlatWhite()
    }
    
    static func titleTheme() -> UIColor {
        return FlatCoffeeDark()
    }
    
    static func textTheme() -> UIColor {
        return FlatMint()
    }
    
    static func backgroudTheme() -> UIColor {
        return FlatMint()
    }
    
    static func positiveTheme() -> UIColor {
        return FlatMint()
    }
    
    static func negativeTheme() -> UIColor {
        return FlatRed()
    }
    
    static func clearTheme() -> UIColor {
        return UIColor.clear
    }
    
    // MARK: - Content
    
    static func content() -> UIContentStyle {
        return UIContentStyle.contrast
    }
    
    // MARK: - Font
    static func font() -> String {
        return UIFont(name: FontType.Primary.fontName, size: FontType.Primary.fontSize)!.fontName
    }
}

//MARK: - FontType
enum FontType {
    case Primary
}

extension FontType {
    var fontName: String {
        switch self {
        case .Primary:
            return "Avenir"
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .Primary:
            return 17
        }
    }
}
