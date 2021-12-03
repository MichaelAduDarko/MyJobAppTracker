//
//  StackScrollView.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 12/2/21.
//

import UIKit

final class StackScrollView: UIScrollView {
    // MARK: - Properties
    let contentEdgeInsets: UIEdgeInsets
    // MARK: - Init
    init(contentEdgeInsets: UIEdgeInsets = .init(top: 16, left: 16, bottom: 0, right: 16)) {
        self.contentEdgeInsets = contentEdgeInsets
        super.init(frame: .zero)
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UI
    private func setUI() {
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        backgroundColor = .systemGray6
        alwaysBounceVertical = true
        addSubview(stackView)
        stackView.layoutMargins = contentEdgeInsets
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    // MARK: - Operations
    func insertView(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    // MARK: - Components
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
}


