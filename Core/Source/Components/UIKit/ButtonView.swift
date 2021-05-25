//
//  ButtonView.swift
//  Core
//
//  Created by Daniel Tarazona on 2/05/21.
//

import Foundation
import UIKit

enum ButtonType: String, CaseIterable {
    case primary
    case secundary
    case link
}

struct ButtonViewModel {
    var type: ButtonType
    var title: String
    var color: UIColor
    var bold: Bool
    var alignment: NSTextAlignment
    var pageName: String
    var prefix: String


    init(
        type: ButtonType = .primary,
        title: String = "",
        color: UIColor = .black,
        bold: Bool = true,
        alignment: NSTextAlignment = .left,
        prefix: String = "",
        pageName: String = ""
    ) {
        self.type = type
        self.title = title
        self.alignment = alignment
        self.pageName = pageName
        self.prefix = prefix
        self.color = color
        self.bold = bold
    }
}

class ButtonView: UIView {

    var viewModel: ButtonViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            switch viewModel.type {
            case .primary:
                buttonView.primary(
                    title: viewModel.title,
                    bold: viewModel.bold
                )
            case .link:
                buttonView.link(
                    title: viewModel.title,
                    bold: viewModel.bold
                )
            default:
                buttonView.primary(
                    title: viewModel.title,
                    bold: viewModel.bold
                )
            }

            accessibilityIdentifier = "\(viewModel.pageName)\(viewModel.prefix)\(TextView.self)"
        }
    }

    lazy var buttonView: UIButton = {
        let button = UIButton().autolayout()
        button.primary(bold: true)
        return button
    }()

    required init?(coder: NSCoder) {
        super.init(frame: CGRect.zero)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        addSubview(buttonView)

        buttonView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
