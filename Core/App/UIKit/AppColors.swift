//
//  AppColors.swift
//  Core
//
//  Created by Daniel Tarazona on 2/05/21.
//

import UIKit.UIColor

protocol AppColor {
    var color: UIColor { get }
}

extension UIColor {

    // White
    @nonobjc class var whiteToBlack: UIColor {
      return dynamicColor(UIColor.white, UIColor.black)
    }

    // Black
    @nonobjc class var  blackToWhite: UIColor {
      return dynamicColor(UIColor.black, UIColor.white)
    }

    // DarkGray
    @nonobjc class var  gray500ToGray050: UIColor {
      return dynamicColor(UIColor.gray500, UIColor.gray050)
    }

    // LightGray
    @nonobjc class var  gray200ToGray075: UIColor {
      return dynamicColor(UIColor.gray200, UIColor.gray075)
    }

    // Primary
    @nonobjc class var  blue100ToBlue050: UIColor {
      return dynamicColor(UIColor.blue100, UIColor.blue050)
    }

    // Secondary
    @nonobjc class var  lBlue100ToLBlue050: UIColor {
      return dynamicColor(UIColor.lBlue100, UIColor.lBlue050)
    }

    // danger
    @nonobjc class var  red100ToRed050: UIColor {
      return dynamicColor(UIColor.red100, UIColor.red050)
    }

    // Warning
    @nonobjc class var  orange100ToOrange050: UIColor {
      return dynamicColor(UIColor.orange100, UIColor.orange050)
    }

    // Disabled, whiteToVeryDarkBlue
    @nonobjc class var  gray050ToGray500: UIColor {
      return dynamicColor(UIColor.gray050, UIColor.gray500)
    }

    // clearToVeryDarkGray, whiteToVeryDarkGray
    @nonobjc class var whiteToGray500: UIColor {
      return dynamicColor(UIColor.white, UIColor.gray500)
    }

    // whiteToDarkGray
    @nonobjc class var  whiteToWarmGrey: UIColor {
      return dynamicColor(UIColor.white, UIColor.warmGrey)
    }

    // whiteToVeryLightGray
    @nonobjc class var  whiteToGray050: UIColor {
      return dynamicColor(UIColor.white, UIColor.gray050)
    }

    // whiteToVerySoftBlue = dynamicColor("FFFFFF", "A5C6F4")
    @nonobjc class var  whiteToBlue050: UIColor {
      return dynamicColor(UIColor.white, UIColor.blue050)
    }

    // grayishBlueToDarkGrayishBlue
    @nonobjc class var  gray075ToGray100: UIColor {
      return dynamicColor(UIColor.gray075, UIColor.gray100)
    }

    // grayishBlueToLightGrayishYellow
    @nonobjc class var  gray075ToYellow025: UIColor {
      return dynamicColor(UIColor.gray075, UIColor.yellow075)
    }

    // veryDarkGrayishBlueToVeryLightGray
    @nonobjc class var  gray400ToGray050: UIColor {
      return dynamicColor(UIColor.gray400, UIColor.gray050)
    }

    // veryDarkGrayishBlueToLightGrayBlue
    @nonobjc class var  gray400ToGray025: UIColor {
      return dynamicColor(UIColor.gray400, UIColor.gray025)
    }

    // orange
    @nonobjc class var orange: UIColor {
        return UIColor.orange100
    }

    // invertedPrimary
    @nonobjc class var whiteToBlue100: UIColor {
        return dynamicColor(UIColor.white, UIColor.blue100)
    }

    // primaryToBlack, vividBlueToBlack
    @nonobjc class var blue100ToBlack: UIColor {
        return dynamicColor(UIColor.blue100, UIColor.black)
    }

    // primaryToWhite, vividBlueToWhite
    @nonobjc class var blue100ToWhite: UIColor {
        return dynamicColor(UIColor.blue100, UIColor.white)
    }
}

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0
        )
    }

    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }

    static func from(hex: String) -> UIColor {

      let cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

      if cString.count != 6 {
        return UIColor.gray
      }

      var rgbValue: UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)

      return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
      )
    }

    static func dynamicColor(_ light: String, _ dark: String) -> UIColor {
        let lightHex = from(hex: light)
        let darkHex = from(hex: dark)
        let dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .unspecified, .light: return lightHex.resolvedColor(with: traitCollection)
            case .dark: return darkHex.resolvedColor(with: traitCollection)
            @unknown default: return lightHex.resolvedColor(with: traitCollection)
            }
        }
        return dynamicColor
    }

    static func dynamicColor(_ light: UIColor, _ dark: UIColor) -> UIColor {
        let dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .unspecified, .light: return light.resolvedColor(with: traitCollection)
            case .dark: return dark.resolvedColor(with: traitCollection)
            @unknown default: return light.resolvedColor(with: traitCollection)
            }
        }
        return dynamicColor
    }
}

extension UIColor {
  @nonobjc class var veryLightBlue: UIColor {
    return UIColor(red: 221, green: 233, blue: 251)
  }
  @nonobjc class var warmGrey: UIColor {
    return UIColor(white: 125, alpha: 1.0)
  }
  @nonobjc class var lightGrey: UIColor {
    return UIColor(red: 248, green: 249, blue: 249)
  }
  @nonobjc class var blackTwo: UIColor {
    return UIColor(white: 30, alpha: 1.0)
  }
  @nonobjc class var blue025: UIColor {
    return UIColor(red: 221, green: 233, blue: 250)
  }
  @nonobjc class var blue050: UIColor {
    return UIColor(red: 164, green: 197, blue: 242)
  }
  @nonobjc class var blue075: UIColor {
    return UIColor(red: 85, green: 147, blue: 231)
  }
  @nonobjc class var blue100: UIColor {
    return UIColor(red: 29, green: 111, blue: 224)
  }
  @nonobjc class var blue200: UIColor {
    return UIColor(red: 23, green: 88, blue: 197)
  }
  @nonobjc class var blue300: UIColor {
    return UIColor(red: 15, green: 62, blue: 161)
  }
  @nonobjc class var blue400: UIColor {
    return UIColor(red: 8, green: 32, blue: 115)
  }
  @nonobjc class var lBlue025: UIColor {
    return UIColor(red: 236, green: 247, blue: 1)
  }
  @nonobjc class var lBlue050: UIColor {
    return UIColor(red: 204, green: 234, blue: 1)
  }
  @nonobjc class var lBlue075: UIColor {
    return UIColor(red: 159, green: 216, blue: 1)
  }
  @nonobjc class var lBlue100: UIColor {
    return UIColor(red: 128, green: 204, blue: 1)
  }
  @nonobjc class var lBlue200: UIColor {
    return UIColor(red: 103, green: 177, blue: 229)
  }
  @nonobjc class var lBlue300: UIColor {
    return UIColor(red: 71, green: 143, blue: 191)
  }
  @nonobjc class var lBlue400: UIColor {
    return UIColor(red: 38, green: 99, blue: 140)
  }
  @nonobjc class var purple025: UIColor {
    return UIColor(red: 235, green: 223, blue: 250)
  }
  @nonobjc class var purple050: UIColor {
    return UIColor(red: 202, green: 170, blue: 241)
  }
  @nonobjc class var purple075: UIColor {
    return UIColor(red: 156, green: 96, blue: 230)
  }
  @nonobjc class var purple100: UIColor {
    return UIColor(red: 124, green: 44, blue: 222)
  }
  @nonobjc class var purple200: UIColor {
    return UIColor(red: 99, green: 35, blue: 195)
  }
  @nonobjc class var purple300: UIColor {
    return UIColor(red: 68, green: 23, blue: 159)
  }
  @nonobjc class var purple400: UIColor {
    return UIColor(red: 43, green: 15, blue: 115)
  }
  @nonobjc class var green025: UIColor {
    return UIColor(red: 222, green: 245, blue: 230)
  }
  @nonobjc class var green050: UIColor {
    return UIColor(red: 167, green: 228, blue: 189)
  }
  @nonobjc class var green075: UIColor {
    return UIColor(red: 90, green: 205, blue: 132)
  }
  @nonobjc class var green100: UIColor {
    return UIColor(red: 36, green: 189, blue: 92)
  }
  @nonobjc class var green200: UIColor {
    return UIColor(red: 28, green: 163, blue: 73)
  }
  @nonobjc class var green300: UIColor {
    return UIColor(red: 19, green: 128, blue: 50)
  }
  @nonobjc class var green400: UIColor {
    return UIColor(red: 10, green: 87, blue: 27)
  }
  @nonobjc class var lgreen025: UIColor {
    return UIColor(red: 240, green: 250, blue: 230)
  }
  @nonobjc class var lgreen050: UIColor {
    return UIColor(red: 217, green: 241, blue: 189)
  }
  @nonobjc class var lgreen075: UIColor {
    return UIColor(red: 184, green: 230, blue: 132)
  }
  @nonobjc class var lgreen100: UIColor {
    return UIColor(red: 161, green: 222, blue: 91)
  }
  @nonobjc class var lgreen200: UIColor {
    return UIColor(red: 135, green: 195, blue: 72)
  }
  @nonobjc class var lgreen300: UIColor {
    return UIColor(red: 102, green: 159, blue: 50)
  }
  @nonobjc class var lgreen400: UIColor {
    return UIColor(red: 64, green: 113, blue: 26)
  }
  @nonobjc class var yellow025: UIColor {
    return UIColor(red: 1, green: 247, blue: 224)
  }
  @nonobjc class var yellow050: UIColor {
    return UIColor(red: 1, green: 235, blue: 171)
  }
  @nonobjc class var yellow075: UIColor {
    return UIColor(red: 1, green: 218, blue: 99)
  }
  @nonobjc class var yellow100: UIColor {
    return UIColor(red: 1, green: 206, blue: 47)
  }
  @nonobjc class var yellow200: UIColor {
    return UIColor(red: 229, green: 180, blue: 37)
  }
  @nonobjc class var yellow300: UIColor {
    return UIColor(red: 191, green: 144, blue: 26)
  }
  @nonobjc class var yellow400: UIColor {
    return UIColor(red: 140, green: 100, blue: 13)
  }
  @nonobjc class var orange025: UIColor {
    return UIColor(red: 253, green: 236, blue: 221)
  }
  @nonobjc class var orange050: UIColor {
    return UIColor(red: 252, green: 205, blue: 165)
  }
  @nonobjc class var orange075: UIColor {
    return UIColor(red: 249, green: 162, blue: 87)
  }
  @nonobjc class var orange100: UIColor {
    return UIColor(red: 248, green: 131, blue: 32)
  }
  @nonobjc class var orange200: UIColor {
    return UIColor(red: 221, green: 105, blue: 25)
  }
  @nonobjc class var orang300: UIColor {
    return UIColor(red: 184, green: 74, blue: 17)
  }
  @nonobjc class var orange400: UIColor {
    return UIColor(red: 133, green: 41, blue: 9)
  }
  @nonobjc class var red025: UIColor {
    return UIColor(red: 248, green: 225, blue: 229)
  }
  @nonobjc class var red050: UIColor {
    return UIColor(red: 236, green: 174, blue: 187)
  }
  @nonobjc class var red075: UIColor {
    return UIColor(red: 220, green: 104, blue: 127)
  }
  @nonobjc class var red100: UIColor {
    return UIColor(red: 209, green: 54, blue: 85)
  }
  @nonobjc class var red200: UIColor {
    return UIColor(red: 183, green: 43, blue: 68)
  }
  @nonobjc class var red300: UIColor {
    return UIColor(red: 147, green: 29, blue: 47)
  }
  @nonobjc class var red400: UIColor {
    return UIColor(red: 103, green: 15, blue: 25)
  }
  @nonobjc class var gray005: UIColor {
    return UIColor(red: 248, green: 249, blue: 250)
  }
  @nonobjc class var gray025: UIColor {
    return UIColor(red: 236, green: 239, blue: 242)
  }
  @nonobjc class var gray050: UIColor {
    return UIColor(red: 206, green: 213, blue: 222)
  }
  @nonobjc class var gray075: UIColor {
    return UIColor(red: 164, green: 176, blue: 194)
  }
  @nonobjc class var gray100: UIColor {
    return UIColor(red: 134, green: 150, blue: 174)
  }
  @nonobjc class var gray200: UIColor {
    return UIColor(red: 120, green: 134, blue: 156)
  }
  @nonobjc class var gray300: UIColor {
    return UIColor(red: 100, green: 112, blue: 130)
  }
  @nonobjc class var gray400: UIColor {
    return UIColor(red: 66, green: 74, blue: 86)
  }
  @nonobjc class var gray500: UIColor {
    return UIColor(red: 53, green: 60, blue: 69)
  }
}

