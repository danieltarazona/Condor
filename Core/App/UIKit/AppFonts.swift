//
//  AppFonts.swift
//  Core
//
//  Created by Daniel Tarazona on 2/05/21.
//

import UIKit

extension UILabel {

    func base(_ title: String = "") {
        self.isAccessibilityElement = true
        self.accessibilityLabel = "\(title.localized)"
        self.text = title.localized
        self.accessibilityTraits = .staticText
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }

    func h(
        _ size: CGFloat = 12,
        viewModel: TextViewModel
    ) {
        base(viewModel.title)
        textColor = viewModel.color
        textAlignment = viewModel.align
        font = (viewModel.bold && !viewModel.italic) ? .bold(size) :
            (!viewModel.bold && viewModel.italic ? .italic(size) :
                (viewModel.bold && viewModel.italic ? .boldItalic(size) :
                .regular(size)
            )
        )
    }


    func h(
        _ size: CGFloat = 12,
        title: String = "h12",
        color: UIColor = .black,
        bold: Bool = false,
        align: NSTextAlignment = .left,
        italic: Bool = false
    ) {
        base(title)
        textColor = color
        textAlignment = align
        font = (bold && !italic) ? .bold(size) :
            (!bold && italic ? .italic(size) :
                (bold && italic ? .boldItalic(size) :
                .regular(size)
            )
        )
    }
}

extension UIFont {
    class func regular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Regular", size: size) ?? .systemFont(ofSize: size)
    }

    class func italic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Italic", size: size) ?? .systemFont(ofSize: size)
    }

    class func bold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Bold", size: size) ?? .systemFont(ofSize: size)
    }

    class func boldItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-BoldItalic", size: size) ?? .systemFont(ofSize: size)
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIView {
    @discardableResult func autolayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func anchorToView(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        activate([
            self.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: insets.right),
            self.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: insets.left),
            self.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: insets.top),
            self.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: insets.bottom)
        ])
    }

    func anchorToLayoutGuide(_ layoutGuide: UILayoutGuide) {
        activate([
            self.trailingAnchor.constraint(
                equalTo: layoutGuide.trailingAnchor),
            self.leadingAnchor.constraint(
                equalTo: layoutGuide.leadingAnchor),
            self.topAnchor.constraint(
                equalTo: layoutGuide.topAnchor),
            self.bottomAnchor.constraint(
                equalTo: layoutGuide.bottomAnchor)
        ])
    }

    func activate(_ layoutConstraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(layoutConstraints)
    }
}

