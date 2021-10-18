//
//  shadow.swift
//  Turkmen Afisha News
//
//  Created by izi on 06.07.2021.
//

import UIKit

class RoundedShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize (width: 3, height: 3)
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}


class ViewForRoundImage: UIView {
    override func awakeFromNib() {
        layer.cornerRadius = (layer.frame.height ) / 2
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize (width: 2, height: 2)
        layer.shadowRadius = 2
    }
}


class RoundedView: UIView {
    override func awakeFromNib() {
        layer.cornerRadius = layer.frame.height / 2
    }
}


class RoundBlueBorder: UILabel {
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.00370885944, green: 0.4568774104, blue: 0.8472879529, alpha: 1)
    }
}


class RoundImage: UIImageView {
    override func awakeFromNib() {
        layer.cornerRadius = layer.frame.height / 2
        
    }
}

class RoundingTopCorners: UIView {
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.shadowColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize (width: -1, height: -1)
        layer.shadowRadius = 2
        
    }
}

class RoundingBottomCorners: UIView {
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.shadowColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize (width: 1, height: 1)
        layer.shadowRadius = 2
    }
}

class RoundButton: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.shadowColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize (width: 1, height: 1)
        layer.shadowRadius = 2
    }
}


