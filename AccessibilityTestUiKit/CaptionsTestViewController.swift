//
//  CaptionsTestViewController.swift
//  AccessibilityTestUiKit
//
//  Migrated from SwiftUI Nutrition Label app
//

import UIKit
import SwiftUI
import AVKit
import AVFoundation

class CaptionsTestViewController: UIViewController {

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
        contentStackView.addArrangedSubview(createCaptionTypesSection())
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
        titleLabel.text = "How to Enable Captions"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let steps = [
            "1. Open Settings app",
            "2. Go to Accessibility",
            "3. Tap Subtitles & Captioning",
            "4. Toggle Closed Captions + SDH ON",
            "5. Tap Style to customize appearance"
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

    private func createCaptionTypesSection() -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 16
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        container.isLayoutMarginsRelativeArrangement = true
        container.backgroundColor = .secondarySystemGroupedBackground
        container.layer.cornerRadius = 12

        let titleLabel = UILabel()
        titleLabel.text = "Caption Types"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        container.addArrangedSubview(titleLabel)

        let types = [
            ("text.bubble.fill", "Dialogue", "Spoken words"),
            ("waveform", "Sound Effects", "[door slams], [phone rings]"),
            ("person.fill", "Speaker ID", "JANE: Hello"),
            ("music.note", "Music/Tone", "♪ [upbeat music] ♪")
        ]

        for type in types {
            let badge = createCaptionTypeBadge(icon: type.0, title: type.1, description: type.2)
            container.addArrangedSubview(badge)
        }

        return container
    }

    private func createCaptionTypeBadge(icon: String, title: String, description: String) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .top

        let iconView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        iconView.image = UIImage(systemName: icon, withConfiguration: config)
        iconView.tintColor = .systemPink
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
        // Using Apple's HLS test stream with captions
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8") else { return }

        player = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player

        // Enable caption selection
        if let player = player, let playerItem = player.currentItem {
            let legibleGroup = playerItem.asset.mediaSelectionGroup(forMediaCharacteristic: .legible)
            if let legibleGroup = legibleGroup {
                let locale = Locale.current
                let options = AVMediaSelectionGroup.mediaSelectionOptions(from: legibleGroup.options, with: locale)
                if let option = options.first {
                    playerItem.select(option, in: legibleGroup)
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

#Preview("Captions") {
    let vc = CaptionsTestViewController()
    vc.title = "Captions"
    let nav = UINavigationController(rootViewController: vc)
    nav.navigationBar.prefersLargeTitles = true
    return nav
}
