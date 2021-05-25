//
//  AppButtons.swift
//  Core
//
//  Created by Daniel Tarazona on 2/05/21.
//

import UIKit

extension UIButton {

    private func base(_ title: String = "") {
        clipsToBounds = true
        layer.cornerRadius = 4

        self.accessibilityTraits = [.button]
        self.isAccessibilityElement = true
        self.accessibilityLabel = "\(title.localized)"

        setTitle(title.localized, for: .normal)
        titleLabel?.font = .bold(16)
        titleLabel?.textAlignment = .center

        setBackgroundImage(nil, for: .normal)
        setBackgroundImage(nil, for: .selected)
        setBackgroundImage(nil, for: .disabled)
    }

    // MARK: Bootstrap

    func primary(
        title: String = "",
        size: CGFloat = 16,
        bold: Bool = false,
        align: ContentHorizontalAlignment = .center,
        inverted: Bool = false
    ) {
        base(title)
        titleLabel?.font = bold ? .bold(size) : .regular(size)
        setTitleColor(inverted ? .blue100ToBlack : .whiteToBlack, for: .normal)
        backgroundColor = inverted ? .whiteToBlue100 : .blue100ToBlue050
        contentHorizontalAlignment = align
    }

    func secondary(title: String = "", align: ContentHorizontalAlignment = .center) {
        base(title)
        setTitleColor(.whiteToBlack, for: .normal)
        backgroundColor = .lBlue100ToLBlue050
        contentHorizontalAlignment = align
    }

    func success(title: String = "", align: ContentHorizontalAlignment = .center) {
        base(title)
        setTitleColor(.whiteToBlack, for: .normal)
        contentHorizontalAlignment = align
    }

    func danger(title: String = "", align: ContentHorizontalAlignment = .center) {
        base(title)
        backgroundColor = .red100ToRed050
        contentHorizontalAlignment = align
    }

    func warning(title: String = "", align: ContentHorizontalAlignment = .center) {
        base(title)
        setTitleColor(.whiteToBlack, for: .normal)
        backgroundColor = .orange100ToOrange050
        contentHorizontalAlignment = align
    }
    func pequalTheme(title: String = "") {
        base(title)
        setTitleColor(.whiteToBlack, for: .normal)
        backgroundColor = .blue100ToBlue050
        contentHorizontalAlignment = .center
    }
    func applyNow(title: String = "") {
        base(title)
        setTitleColor(.whiteToBlack, for: .normal)
        backgroundColor = .blue100ToBlue050
        contentHorizontalAlignment = .center
    }

    func link(
        title: String = "",
        color: UIColor = .blue100ToBlue050,
        size: CGFloat = 16,
        bold: Bool = true,
        align: ContentHorizontalAlignment = .center
    ) {
        base(title)
        setTitleColor(color, for: .normal)
        setTitleColor(color, for: .selected)
        titleLabel?.font = bold ? .bold(size) : .regular(size)
        backgroundColor = .clear
        contentHorizontalAlignment = align
    }

    func disabled(title: String = "") {
        base(title)
    }

    func outline(title: String = "", color: UIColor = .blue100ToBlue050) {
        link(title: title, color: color)

        layer.borderWidth = 2
        layer.borderColor = color.cgColor
    }

    func rounded(
        title: String = "",
        tintColor: UIColor? = .none,
        size: CGFloat = 16,
        bold: Bool = true,
        selected: Bool = true,
        borderColor: UIColor? = nil
    ) {
        base(title)
        titleLabel?.font = selected ?
            (bold ? .bold(size + 1) : .regular(size + 1)) :
            (bold ? .bold(size) : .regular(size))
        backgroundColor = selected ? .blue100ToBlue050 : .clear
        setTitleColor(selected ? .whiteToBlack : .blue100ToBlue050, for: .normal)
        layer.cornerRadius = frame.size.height / 2
        if let borderColor = borderColor {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = 2
        }
    }

    // MARK: Special

    func apply(title: String = "Apply Now") {
        applyNow(title: title)
    }

    func outlineRounded(title: String = "") {
        rounded()
        outline(title: title)

        layer.cornerRadius = frame.size.height / 2
    }

    func disabledAndOutline(title: String = "") {
        disabled()
        outline(title: title)
    }


    func textLink(
        title: String,
        linkTitle: String,
        size: CGFloat = 16,
        textColor: UIColor = .blackToWhite,
        linkColor: UIColor = .blue100ToBlue050,
        underlined: Bool = false,
        align: ContentHorizontalAlignment = .center
    ) {

        let attributedText = NSMutableAttributedString.init(string: title)

        attributedText.addAttribute(
            NSAttributedString.Key.font, value: UIFont.regular(size),
            range: NSRange.init(location: 0, length: title.count)
        )
        attributedText.addAttribute(
            NSAttributedString.Key.foregroundColor, value: textColor,
            range: NSRange.init(location: 0, length: title.count)
        )

        attributedText.addAttribute(
            NSAttributedString.Key.font, value: UIFont.regular(size),
            range: (title as NSString).range(of: linkTitle)
        )
        attributedText.addAttribute(
            NSAttributedString.Key.foregroundColor, value: linkColor,
            range: (title as NSString).range(of: linkTitle)
        )
        if underlined {
            attributedText.addAttribute(
                NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue,
                range: (title as NSString).range(of: linkTitle)
            )
        }

        setAttributedTitle(attributedText, for: .normal)

        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.numberOfLines = 0
        contentHorizontalAlignment = .center
    }

    func withLeft(image: String, tint: UIColor = .blue100ToBlue050, margin: CGFloat = 16) {
        tintColor = tint
        let image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -margin, bottom: 0, right: 0)
    }

    func withRight(image: String, tint: UIColor = .blue100ToBlue050, margin: CGFloat = 8) {
        tintColor = tint
        setImage(UIImage(named: image)?.withRenderingMode(.alwaysTemplate), for: .normal)
        semanticContentAttribute = .forceRightToLeft
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -margin)
    }

    func roundedWithLeftImage(title: String = "", image: String = "") {
        rounded(title: title)
        imageView?.tintColor = .gray050ToGray500
        withLeft(image: image)
    }

    func shadow(title: String = "") {
        link(title: title)
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
    }

    func shadowWithImage(name: String = "") {
        shadow(title: name)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)

        backgroundColor = .whiteToGray500
        layer.masksToBounds = false

        let image = UIImage(named: name)
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        contentHorizontalAlignment = .left
        imageView?.contentMode = .scaleAspectFit
    }

    private func actionHandler(action: (() -> Void)? = nil) {
        struct Task {
            static var action: (() -> Void)?
        }

        if action != nil {
            Task.action = action
        } else {
            Task.action?()
        }
    }

    @objc private func triggerActionHandler() {
        actionHandler()
    }

    func actionHandler(controlEvents control: UIControl.Event, for action: @escaping () -> Void) {
        actionHandler(action: action)
        addTarget(self, action: #selector(triggerActionHandler), for: control)
    }

    func withCenter(
        image: String,
        tint: UIColor = .blue100ToBlue050,
        margin: CGFloat = 8
    ) {
        tintColor = tint
        let image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}

