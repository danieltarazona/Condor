//
//  TitleView.swift
//  Core
//
//  Created by Daniel Tarazona on 2/05/21.
//

import UIKit

struct TextViewModel {
    var size: CGFloat
    var title: String
    var align: NSTextAlignment
    var pageName: String
    var prefix: String
    var color: UIColor
    var bold: Bool
    var italic: Bool

    init(
        size: CGFloat = 12,
        title: String = "",
        color: UIColor = UIColor.blackToWhite,
        bold: Bool = false,
        italic: Bool = false,
        align: NSTextAlignment = .left,
        prefix: String = "",
        pageName: String = ""
    ) {
        self.size = size
        self.title = title
        self.align = align
        self.pageName = pageName
        self.prefix = prefix
        self.color = color
        self.bold = bold
        self.italic = italic
    }
}

class TextView: UIView {

    var viewModel: TextViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            label.h(viewModel.size, viewModel: viewModel)

            accessibilityIdentifier = "\(viewModel.pageName)\(viewModel.prefix)\(TextView.self)"
        }
    }

    lazy var label: UILabel = {
        let label = UILabel()
        return label
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
        addSubview(label)

        label.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
        }

        label.anchorToView(self)
    }
}

