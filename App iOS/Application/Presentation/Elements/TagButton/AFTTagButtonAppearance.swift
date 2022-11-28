//
//  AFTTagButtonAppearance.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import Rswift

enum AFTTagButtonAppearance {
    case primary
    case outlined
    case grayOutlined
}

extension AFTTagButtonAppearance {
    
    var backgroundColor: UIColor {
        switch self {
        case .primary: return R.color.primary()!
        case .outlined: return R.color.background()!
        case .grayOutlined: return R.color.background()!
        }
    }

    var textColor: UIColor {
        switch self {
        case .primary: return R.color.background()!
        case .outlined: return R.color.primary()!
        case .grayOutlined: return R.color.highContrast()!
        }
    }

    var borderColor: CGColor {
        switch self {
        case .primary: return UIColor.clear.cgColor
        case .outlined: return R.color.primary()!.cgColor
        case .grayOutlined: return R.color.lowContrast()!.cgColor
        }
    }

    var borderWidth: CGFloat {
        switch self {
        case .primary: return 0
        case .outlined: return 1
        case .grayOutlined: return 1
        }
    }

    var titleFont: UIFont {
        switch self {
        case .primary: return R.font.poppinsRegular(size: 13)!
        case .outlined: return R.font.poppinsSemiBold(size: 14)!
        case .grayOutlined: return R.font.poppinsRegular(size: 13)!
        }
    }
}
