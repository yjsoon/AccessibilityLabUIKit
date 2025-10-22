//
//  ContrastTestViewController.swift
//  AccessibilityTestUiKit
//
//  Migrated from SwiftUI Nutrition Label app
//

import UIKit

class ContrastTestViewController: UIViewController {

    private var scrollView: UIScrollView!
    private var contentStackView: UIStackView!

    private var isIncreasedContrast: Bool {
        return UIAccessibility.isDarkerSystemColorsEnabled
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupContentStackView()
        setupContent()

        NotificationCenter.default.addObserver(self, selector: #selector(contrastChanged), name: UIAccessibility.darkerSystemColorsStatusDidChangeNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func contrastChanged() {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        setupContent()
    }

    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupContentStackView() {
        contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.spacing = 24
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }

    private func setupContent() {
        contentStackView.addArrangedSubview(createStatusIndicator())
        contentStackView.addArrangedSubview(createTextContrastSection())
        contentStackView.addArrangedSubview(createButtonContrastSection())
        contentStackView.addArrangedSubview(createSeparatorsSection())
        contentStackView.addArrangedSubview(createInfoSection())
    }

    private func createStatusIndicator() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        container.isLayoutMarginsRelativeArrangement = true
        container.backgroundColor = .secondarySystemGroupedBackground
        container.layer.cornerRadius = 12

        let titleLabel = UILabel()
        titleLabel.text = "Feature Status"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let statusLabel = UILabel()
        statusLabel.text = isIncreasedContrast ? "Increased Contrast: ON" : "Increased Contrast: OFF"
        statusLabel.font = .preferredFont(forTextStyle: .title3)
        statusLabel.adjustsFontForContentSizeCategory = true
        statusLabel.textAlignment = .center
        container.addArrangedSubview(statusLabel)

        let wcagLabel = UILabel()
        wcagLabel.text = isIncreasedContrast ? "WCAG Level: AAA" : "WCAG Level: AA"
        wcagLabel.font = .preferredFont(forTextStyle: .body)
        wcagLabel.adjustsFontForContentSizeCategory = true
        wcagLabel.textAlignment = .center
        wcagLabel.textColor = .secondaryLabel
        container.addArrangedSubview(wcagLabel)

        return container
    }

    private func createTextContrastSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 16
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        container.isLayoutMarginsRelativeArrangement = true
        container.backgroundColor = .secondarySystemGroupedBackground
        container.layer.cornerRadius = 12

        let titleLabel = UILabel()
        titleLabel.text = "Text Contrast"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let primaryText = createTextRow(text: "Primary Text", color: .label, wcagLevel: "AAA")
        container.addArrangedSubview(primaryText)

        let secondaryText = createTextRow(text: "Secondary Text", color: .secondaryLabel, wcagLevel: "AA")
        container.addArrangedSubview(secondaryText)

        return container
    }

    private func createTextRow(text: String, color: UIColor, wcagLevel: String) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center

        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = color
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.addArrangedSubview(label)

        let badgeLabel = UILabel()
        badgeLabel.text = wcagLevel
        badgeLabel.font = .preferredFont(forTextStyle: .caption1)
        badgeLabel.adjustsFontForContentSizeCategory = true
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = isIncreasedContrast ? .systemGreen : .systemBlue
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 4
        badgeLabel.layer.masksToBounds = true
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(badgeLabel)

        NSLayoutConstraint.activate([
            badgeLabel.widthAnchor.constraint(equalToConstant: 40),
            badgeLabel.heightAnchor.constraint(equalToConstant: 24)
        ])

        return stackView
    }

    private func createButtonContrastSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        container.isLayoutMarginsRelativeArrangement = true
        container.backgroundColor = .secondarySystemGroupedBackground
        container.layer.cornerRadius = 12

        let titleLabel = UILabel()
        titleLabel.text = "Button Contrast"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let primaryButton = createContrastButton(title: "Primary Button", color: .systemBlue)
        container.addArrangedSubview(primaryButton)

        let secondaryButton = createContrastButton(title: "Secondary Button", color: .systemGray)
        container.addArrangedSubview(secondaryButton)

        return container
    }

    private func createContrastButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = isIncreasedContrast ? 2 : 0
        button.layer.borderColor = color.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        return button
    }

    private func createSeparatorsSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.layer.cornerRadius = 12
        container.layer.masksToBounds = true
        container.backgroundColor = .secondarySystemGroupedBackground

        let titleContainer = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "Separators & Borders"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleContainer.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -12)
        ])

        container.addArrangedSubview(titleContainer)

        for i in 1...3 {
            let item = createListItem(text: "List Item \(i)")
            container.addArrangedSubview(item)

            let separator = UIView()
            separator.backgroundColor = .separator
            separator.translatesAutoresizingMaskIntoConstraints = false
            let height = isIncreasedContrast ? 2.0 : 1.0
            separator.heightAnchor.constraint(equalToConstant: height).isActive = true
            container.addArrangedSubview(separator)
        }

        return container
    }

    private func createListItem(text: String) -> UIView {
        let container = UIView()
        container.backgroundColor = .secondarySystemGroupedBackground

        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])

        return container
    }

    private func createInfoSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        container.isLayoutMarginsRelativeArrangement = true
        container.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        container.layer.cornerRadius = 12

        let titleLabel = UILabel()
        titleLabel.text = "About Contrast"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let infoLabel = UILabel()
        infoLabel.text = "Increased contrast enhances the visual distinction between foreground and background elements, making text and controls easier to see.\n\nWCAG AA: 4.5:1 for normal text\nWCAG AAA: 7:1 for normal text (recommended when enabled)"
        infoLabel.font = .preferredFont(forTextStyle: .body)
        infoLabel.adjustsFontForContentSizeCategory = true
        infoLabel.textColor = .secondaryLabel
        infoLabel.numberOfLines = 0
        container.addArrangedSubview(infoLabel)

        return container
    }
}
