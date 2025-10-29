//
//  AudioDescriptionsTestViewController.swift
//  AccessibilityTestUiKit
//
//  Migrated from SwiftUI Nutrition Label app
//

import UIKit
import SwiftUI
import AVKit
import AVFoundation

class AudioDescriptionsTestViewController: UIViewController {

    private var scrollView: UIScrollView!
    private var contentStackView: UIStackView!
    private var player: AVPlayer?
    private var playerViewController: AVPlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupContentStackView()
        setupContent()
        setupVideoPlayer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
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
        contentStackView.addArrangedSubview(createInstructionsSection())
        contentStackView.addArrangedSubview(createVideoPlayerSection())
        contentStackView.addArrangedSubview(createDescriptionTypesSection())
    }

    private func createInstructionsSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        container.isLayoutMarginsRelativeArrangement = true
        container.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        container.layer.cornerRadius = 12

        let titleLabel = UILabel()
        titleLabel.text = "How to Enable Audio Descriptions"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let steps = [
            "1. Open Settings app",
            "2. Go to Accessibility",
            "3. Tap Audio Descriptions",
            "4. Toggle Audio Descriptions ON"
        ]

        for step in steps {
            let label = UILabel()
            label.text = step
            label.font = .preferredFont(forTextStyle: .body)
            label.adjustsFontForContentSizeCategory = true
            label.textColor = .secondaryLabel
            label.numberOfLines = 0
            container.addArrangedSubview(label)
        }

        let infoLabel = UILabel()
        infoLabel.text = "Note: The video must have an audio description track available. Not all videos support this feature."
        infoLabel.font = .preferredFont(forTextStyle: .caption1)
        infoLabel.adjustsFontForContentSizeCategory = true
        infoLabel.textColor = .tertiaryLabel
        infoLabel.numberOfLines = 0
        container.addArrangedSubview(infoLabel)

        return container
    }

    private func createVideoPlayerSection() -> UIView {
        let container = UIView()
        container.backgroundColor = .black
        container.layer.cornerRadius = 12
        container.layer.masksToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false

        // Video player will be added here
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Video Player"
        placeholderLabel.textColor = .white
        placeholderLabel.font = .preferredFont(forTextStyle: .headline)
        placeholderLabel.textAlignment = .center
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 200),
            placeholderLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        return container
    }

    private func createDescriptionTypesSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 16
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        container.isLayoutMarginsRelativeArrangement = true
        container.backgroundColor = .secondarySystemGroupedBackground
        container.layer.cornerRadius = 12

        let titleLabel = UILabel()
        titleLabel.text = "What Gets Described"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let types = [
            ("person.2.fill", "Characters", "Who's on screen, their appearance, expressions"),
            ("location.fill", "Settings", "Where the scene takes place"),
            ("figure.walk", "Actions", "Physical movements, gestures, and activities"),
            ("heart.fill", "Emotions", "Facial expressions and body language"),
            ("text.alignleft", "Text & Graphics", "On-screen text, titles, or visual information")
        ]

        for type in types {
            let badge = createDescriptionTypeBadge(icon: type.0, title: type.1, description: type.2)
            container.addArrangedSubview(badge)
        }

        return container
    }

    private func createDescriptionTypeBadge(icon: String, title: String, description: String) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .top

        let iconView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        iconView.image = UIImage(systemName: icon, withConfiguration: config)
        iconView.tintColor = .systemRed
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(iconView)

        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.spacing = 4

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        textStack.addArrangedSubview(titleLabel)

        let descLabel = UILabel()
        descLabel.text = description
        descLabel.font = .preferredFont(forTextStyle: .body)
        descLabel.adjustsFontForContentSizeCategory = true
        descLabel.textColor = .secondaryLabel
        descLabel.numberOfLines = 0
        textStack.addArrangedSubview(descLabel)

        stackView.addArrangedSubview(textStack)

        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24)
        ])

        return stackView
    }

    private func setupVideoPlayer() {
        // Using Apple's HLS test stream
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8") else { return }

        player = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player

        // Enable audio description selection
        if let player = player, let playerItem = player.currentItem {
            Task { @MainActor in
                do {
                    if let audibleGroup = try await playerItem.asset.loadMediaSelectionGroup(for: .audible) {
                        let audioDescriptionOptions = audibleGroup.options.filter { option in
                            option.hasMediaCharacteristic(.describesVideoForAccessibility)
                        }

                        if let option = audioDescriptionOptions.first {
                            playerItem.select(option, in: audibleGroup)
                        }
                    }
                } catch {
                    #if DEBUG
                    print("Audio description track not available: \(error.localizedDescription)")
                    #endif
                }
            }
        }

        if let playerViewController = playerViewController {
            addChild(playerViewController)
            let videoSection = contentStackView.arrangedSubviews[1]
            videoSection.subviews.forEach { $0.removeFromSuperview() }
            playerViewController.view.frame = videoSection.bounds
            playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            videoSection.addSubview(playerViewController.view)
            playerViewController.didMove(toParent: self)
        }
    }
}

#Preview("Audio Descriptions") {
    let vc = AudioDescriptionsTestViewController()
    vc.title = "Audio Descriptions"
    let nav = UINavigationController(rootViewController: vc)
    nav.navigationBar.prefersLargeTitles = true
    return nav
}
