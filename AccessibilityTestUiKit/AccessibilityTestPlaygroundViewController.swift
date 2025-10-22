//
//  AccessibilityTestPlaygroundViewController.swift
//  AccessibilityTestUiKit
//
//  Migrated from SwiftUI Nutrition Label app
//

import UIKit

class AccessibilityTestPlaygroundViewController: UIViewController {

    // MARK: - Properties
    private let feature: AccessibilityFeature

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
        title = "\(feature.name) Test"
        view.backgroundColor = .systemBackground

        // Route to the appropriate test view
        let testViewController = createTestViewController()
        addTestViewController(testViewController)
    }

    // MARK: - Test View Creation
    private func createTestViewController() -> UIViewController {
        switch feature.name {
        case "VoiceOver":
            return VoiceOverTestViewController()
        case "Voice Control":
            return VoiceControlTestViewController()
        case "Larger Text":
            return LargerTextTestViewController()
        case "Dark Interface":
            return DarkInterfaceTestViewController()
        case "Differentiate Without Color Alone":
            return DifferentiateColorTestViewController()
        case "Sufficient Contrast":
            return ContrastTestViewController()
        case "Reduced Motion":
            return ReducedMotionTestViewController()
        case "Captions":
            return CaptionsTestViewController()
        case "Audio Descriptions":
            return AudioDescriptionsTestViewController()
        default:
            return GenericTestViewController(feature: feature)
        }
    }

    private func addTestViewController(_ testVC: UIViewController) {
        addChild(testVC)
        testVC.view.frame = view.bounds
        testVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(testVC.view)
        testVC.didMove(toParent: self)
    }
}

// MARK: - Generic Test View
class GenericTestViewController: UIViewController {
    private let feature: AccessibilityFeature

    init(feature: AccessibilityFeature) {
        self.feature = feature
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = "Test playground for \(feature.name) coming soon!"
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}
