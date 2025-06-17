//
//  GFSecondaryTitleLabel.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 16/06/25.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        _configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        
        // Create custom font that scales with Dynamic Type but maintains relative size
        let fontMetrics = UIFontMetrics(forTextStyle: .subheadline)
        let customFont = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        self.font = fontMetrics.scaledFont(for: customFont)
    }
    
    private func _configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}


