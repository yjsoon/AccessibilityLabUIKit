//
//  AccessibilityDetailViewController.swift
//  AccessibilityTestUiKit
//
//  Migrated from SwiftUI Nutrition Label app
//

import UIKit

class AccessibilityDetailViewController: UIViewController {

    // MARK: - Properties
    private let feature: AccessibilityFeature
    private var scrollView: UIScrollView!
    private var contentStackView: UIStackView!

    private var isAccessibilitySize: Bool {
        return traitCollection.preferredContentSizeCategory.isAccessibilityCategory
    }

    // MARK: - Initialization
    init(feature: AccessibilityFeature) {
        self.feature = feature
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never

        setupScrollView()
        setupContentStackView()
        populateContent()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // Rebuild content when text size changes
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            populateContent()
        }
    }

    // MARK: - Setup Methods
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
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

    // MARK: - Content Population
    private func populateContent() {
        // Header icon (hidden at accessibility sizes)
        if !isAccessibilitySize {
            let iconView = createIconView()
            contentStackView.addArrangedSubview(iconView)
        }

        // Feature name
        let nameLabel = createFeatureNameLabel()
        contentStackView.addArrangedSubview(nameLabel)

        // Short description (hidden at accessibility sizes)
        if !isAccessibilitySize {
            let shortDescLabel = createShortDescriptionLabel()
            contentStackView.addArrangedSubview(shortDescLabel)
        }

        contentStackView.addArrangedSubview(createDivider())

        // Platforms section (hidden at accessibility sizes)
        if !isAccessibilitySize {
            let platformsSection = createPlatformsSection()
            contentStackView.addArrangedSubview(platformsSection)
            contentStackView.addArrangedSubview(createDivider())
        }

        // About section
        let aboutSection = createAboutSection()
        contentStackView.addArrangedSubview(aboutSection)

        contentStackView.addArrangedSubview(createDivider())

        // How to Enable section
        let howToSection = createHowToEnableSection()
        contentStackView.addArrangedSubview(howToSection)

        contentStackView.addArrangedSubview(createDivider())

        // Test Playground section
        let playgroundSection = createTestPlaygroundSection()
        contentStackView.addArrangedSubview(playgroundSection)

        // For Developers section (hidden at accessibility sizes)
        if !isAccessibilitySize {
            contentStackView.addArrangedSubview(createDivider())
            let developersSection = createDevelopersSection()
            contentStackView.addArrangedSubview(developersSection)
        }

        // Footer (hidden at accessibility sizes)
        if !isAccessibilitySize {
            let footer = createFooter()
            contentStackView.addArrangedSubview(footer)
        }
    }

    // MARK: - UI Component Creators
    private func createIconView() -> UIView {
        let containerView = UIView()
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .medium)
        imageView.image = UIImage(systemName: feature.icon, withConfiguration: config)
        imageView.tintColor = feature.color
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60)
        ])

        return containerView
    }

    private func createFeatureNameLabel() -> UILabel {
        let label = UILabel()
        label.text = feature.name
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

    private func createShortDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.text = feature.shortDescription
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

    private func createDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = .separator
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return divider
    }

    private func createPlatformsSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12

        let titleLabel = UILabel()
        titleLabel.text = "Available On"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        // Platform badges using flow layout
        let badgesView = FlowLayoutView(spacing: 8)
        for platform in feature.platforms {
            let badge = createPlatformBadge(platform: platform)
            badgesView.addArrangedView(badge)
        }
        container.addArrangedSubview(badgesView)

        return container
    }

    private func createPlatformBadge(platform: String) -> UIView {
        let container = UIView()
        container.backgroundColor = feature.color.withAlphaComponent(0.15)
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stackView)

        // Icon
        let iconView = UIImageView()
        let iconName = platformIcon(for: platform)
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
        iconView.image = UIImage(systemName: iconName, withConfiguration: config)
        iconView.tintColor = feature.color
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(iconView)

        // Label
        let label = UILabel()
        label.text = platform
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = feature.color
        stackView.addArrangedSubview(label)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 6),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -6),
            iconView.widthAnchor.constraint(equalToConstant: 14),
            iconView.heightAnchor.constraint(equalToConstant: 14)
        ])

        return container
    }

    private func platformIcon(for platform: String) -> String {
        switch platform.lowercased() {
        case "ios": return "iphone"
        case "ipados": return "ipad"
        case "macos": return "desktopcomputer"
        case "watchos": return "applewatch"
        case "tvos": return "appletv"
        case "visionos": return "visionpro"
        default: return "app.dashed"
        }
    }

    private func createAboutSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12

        let titleLabel = UILabel()
        titleLabel.text = "About"
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let descriptionLabel = UILabel()
        descriptionLabel.text = feature.fullDescription
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 0
        // Add line spacing for better readability
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let attributedText = NSMutableAttributedString(string: feature.fullDescription)
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        descriptionLabel.attributedText = attributedText
        container.addArrangedSubview(descriptionLabel)

        return container
    }

    private func createHowToEnableSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12

        let titleLabel = UILabel()
        titleLabel.text = "How to Enable"
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        // Add numbered steps
        for (index, step) in feature.activationSteps.enumerated() {
            let stepView = createStepView(number: index + 1, text: step)
            container.addArrangedSubview(stepView)
        }

        return container
    }

    private func createStepView(number: Int, text: String) -> UIView {
        let stackView = UIStackView()
        stackView.axis = isAccessibilitySize ? .vertical : .horizontal
        stackView.spacing = 12
        stackView.alignment = isAccessibilitySize ? .leading : .top

        // Number badge
        let numberLabel = UILabel()
        numberLabel.text = "\(number)"
        numberLabel.font = .preferredFont(forTextStyle: .headline)
        numberLabel.adjustsFontForContentSizeCategory = true
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        numberLabel.backgroundColor = feature.color
        numberLabel.layer.cornerRadius = 14
        numberLabel.layer.masksToBounds = true
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(numberLabel)

        // Text label
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.font = .preferredFont(forTextStyle: .body)
        textLabel.adjustsFontForContentSizeCategory = true
        textLabel.numberOfLines = 0
        stackView.addArrangedSubview(textLabel)

        NSLayoutConstraint.activate([
            numberLabel.widthAnchor.constraint(equalToConstant: 28),
            numberLabel.heightAnchor.constraint(equalToConstant: 28)
        ])

        return stackView
    }

    private func createTestPlaygroundSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12

        let titleLabel = UILabel()
        titleLabel.text = "Test Playground"
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let descriptionLabel = UILabel()
        descriptionLabel.text = "Try out \(feature.name) with these interactive examples:"
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        container.addArrangedSubview(descriptionLabel)

        // Button to navigate to test playground
        let button = UIButton(type: .system)
        button.setTitle("Open Test Playground", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = feature.color
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        button.addTarget(self, action: #selector(openTestPlayground), for: .touchUpInside)
        container.addArrangedSubview(button)

        return container
    }

    private func createDevelopersSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12

        let titleLabel = UILabel()
        titleLabel.text = "For Developers"
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let infoLabel = UILabel()
        infoLabel.text = "Check the full description above for implementation tips and best practices."
        infoLabel.font = .preferredFont(forTextStyle: .footnote)
        infoLabel.adjustsFontForContentSizeCategory = true
        infoLabel.textColor = .secondaryLabel
        infoLabel.numberOfLines = 0
        container.addArrangedSubview(infoLabel)

        return container
    }

    private func createFooter() -> UIView {
        let label = UILabel()
        label.text = "Built with UIKit for Accessibility"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

    // MARK: - Actions
    @objc private func openTestPlayground() {
        let playgroundVC = AccessibilityTestPlaygroundViewController(feature: feature)
        navigationController?.pushViewController(playgroundVC, animated: true)
    }
}

// MARK: - Flow Layout View
class FlowLayoutView: UIView {
    private var arrangedViews: [UIView] = []
    private let spacing: CGFloat

    init(spacing: CGFloat = 8) {
        self.spacing = spacing
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addArrangedView(_ view: UIView) {
        arrangedViews.append(view)
        addSubview(view)
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0

        for view in arrangedViews {
            let size = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

            if currentX + size.width > bounds.width && currentX > 0 {
                // Move to next line
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }

            view.frame = CGRect(x: currentX, y: currentY, width: size.width, height: size.height)

            currentX += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        var maxWidth: CGFloat = 0

        for view in arrangedViews {
            let viewSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

            if currentX + viewSize.width > size.width && currentX > 0 {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }

            currentX += viewSize.width + spacing
            lineHeight = max(lineHeight, viewSize.height)
            maxWidth = max(maxWidth, currentX)
        }

        return CGSize(width: maxWidth, height: currentY + lineHeight)
    }

    override var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: bounds.width, height: .greatestFiniteMagnitude))
    }
}
