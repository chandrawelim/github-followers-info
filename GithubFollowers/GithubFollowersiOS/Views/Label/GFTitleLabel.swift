//
//  GFTitleLabel.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 15/06/25.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        _configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.preferredFont(forTextStyle: .title2)
        
        // Create custom font that scales with Dynamic Type but maintains relative size
        let fontMetrics = UIFontMetrics(forTextStyle: .title2)
        let customFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.font = fontMetrics.scaledFont(for: customFont)
    }
    
    private func _configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}


