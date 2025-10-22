//
//  AccessibilityFeature.swift
//  AccessibilityTestUiKit
//
//  Migrated from SwiftUI Nutrition Label app
//

import UIKit

struct AccessibilityFeature: Hashable {
    let id: UUID
    let name: String
    let icon: String
    let shortDescription: String
    let fullDescription: String
    let platforms: [String]
    let color: UIColor
    let activationSteps: [String]
    let category: AccessibilityCategory

    init(id: UUID = UUID(), name: String, icon: String, shortDescription: String, fullDescription: String, platforms: [String], color: UIColor, activationSteps: [String], category: AccessibilityCategory) {
        self.id = id
        self.name = name
        self.icon = icon
        self.shortDescription = shortDescription
        self.fullDescription = fullDescription
        self.platforms = platforms
        self.color = color
        self.activationSteps = activationSteps
        self.category = category
    }

    // MARK: - All Features Data

    static let allFeatures: [AccessibilityFeature] = [
        AccessibilityFeature(
            name: "VoiceOver",
            icon: "speaker.wave.3.fill",
            shortDescription: "Screen reader that lets you navigate your device without seeing the screen.",
            fullDescription: """
VoiceOver is Apple's built-in screen reader that speaks aloud the description of what's on your screen. It lets users with visual impairments navigate and interact with their device using touch gestures or keyboard commands.

When VoiceOver is on, users can:
• Hear spoken descriptions of onscreen elements
• Navigate by swiping or keyboard commands
• Use a rotor to adjust settings and navigate by headings, links, or other page elements
• Interact with apps using custom gestures

**For Developers:**
• Use proper semantic elements and labels
• Provide meaningful `accessibilityLabel` for all interactive elements
• Use `accessibilityHint` to describe what happens when an action is performed
• Test your app with VoiceOver enabled to ensure all content is accessible
""",
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .systemBlue,
            activationSteps: [
                "Open Settings app",
                "Go to Accessibility",
                "Tap VoiceOver",
                "Toggle VoiceOver ON"
            ],
            category: .vision
        ),
        AccessibilityFeature(
            name: "Voice Control",
            icon: "mic.fill",
            shortDescription: "Control your device entirely with your voice.",
            fullDescription: """
Voice Control lets you operate your device completely hands-free using only your voice. You can tap, swipe, type, and more just by speaking commands.

When Voice Control is enabled, users can:
• Tap buttons and controls by saying their names
• Navigate screens using directional commands
• Dictate text in any text field
• Show numbers or a grid overlay for precise control
• Create custom voice commands for frequent actions

**For Developers:**
• Ensure all interactive elements have clear, descriptive labels
• Avoid using generic labels like "button" or "tap here"
• Make sure custom controls have proper accessibility labels
• Test voice navigation through your app's interface
""",
            platforms: ["iOS", "iPadOS", "macOS"],
            color: .systemPurple,
            activationSteps: [
                "Open Settings app",
                "Go to Accessibility",
                "Tap Voice Control",
                "Toggle Voice Control ON"
            ],
            category: .motor
        ),
        AccessibilityFeature(
            name: "Larger Text",
            icon: "textformat.size",
            shortDescription: "Make text easier to read by increasing font size up to 200% or more.",
            fullDescription: """
Dynamic Type allows users to adjust the text size across the entire system and all apps that support it. Users can scale text from very small to accessibility sizes that are significantly larger than default.

Benefits for users:
• Makes text more readable for users with low vision
• Reduces eye strain for all users
• Works system-wide across all compatible apps
• Can be adjusted per-app in iOS 15 and later

**For Developers:**
• Use Dynamic Type fonts (UIFont.preferredFont) instead of fixed sizes
• Support accessibility sizes (AX1 through AX5)
• Ensure your layout adapts to larger text without clipping or overlapping
• Test with the largest text size to verify readability
• Consider switching from horizontal to vertical layouts at larger sizes
""",
            platforms: ["iOS", "iPadOS", "watchOS", "visionOS"],
            color: .systemGreen,
            activationSteps: [
                "Open Settings app",
                "Go to Accessibility",
                "Tap Display & Text Size",
                "Tap Larger Text",
                "Toggle Larger Accessibility Sizes if needed",
                "Adjust the slider to your preferred size"
            ],
            category: .vision
        ),
        AccessibilityFeature(
            name: "Dark Interface",
            icon: "moon.fill",
            shortDescription: "Reduce eye strain with a system-wide dark color scheme.",
            fullDescription: """
Dark Mode transforms the entire interface into a darker color scheme, which can reduce eye strain in low-light conditions and may help users with light sensitivity.

Benefits:
• Reduces eye strain, especially in low-light environments
• Can help users with photophobia or migraine sensitivity
• May improve battery life on OLED displays
• Provides a more comfortable viewing experience at night

**For Developers:**
• Use semantic colors that automatically adapt to light/dark mode
• Provide custom colors for both light and dark appearances
• Test your app in both modes to ensure proper contrast
• Avoid pure black (#000000) - use system backgrounds for better readability
• Ensure images and icons work well in both modes
""",
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .systemIndigo,
            activationSteps: [
                "Open Settings app",
                "Go to Display & Brightness",
                "Select Dark under Appearance"
            ],
            category: .vision
        ),
        AccessibilityFeature(
            name: "Differentiate Without Color Alone",
            icon: "circle.lefthalf.filled",
            shortDescription: "Use shapes and text in addition to color to convey information.",
            fullDescription: """
This setting helps users who have difficulty distinguishing between colors (color blindness affects ~8% of men and ~0.5% of women). When enabled, iOS apps should use additional visual indicators beyond just color.

How it helps:
• Adds icons or text to color-coded elements
• Shows additional context that doesn't rely solely on color
• Makes interfaces accessible to users with any type of color vision deficiency
• Improves clarity for all users

Common use cases:
• Status indicators (success/warning/error) use both color AND icons
• Charts and graphs include patterns or labels
• Required form fields show asterisks in addition to color
• Selection states show checkmarks, not just color changes

**For Developers:**
• Never use color as the only way to convey information
• Add icons, borders, or text labels to color-coded elements
• Use UIAccessibility.shouldDifferentiateWithoutColor to detect this setting
• Provide alternative visual cues for important information
""",
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .systemOrange,
            activationSteps: [
                "Open Settings app",
                "Go to Accessibility",
                "Tap Display & Text Size",
                "Toggle Differentiate Without Color ON"
            ],
            category: .vision
        ),
        AccessibilityFeature(
            name: "Sufficient Contrast",
            icon: "circle.righthalf.filled",
            shortDescription: "Increase contrast between app foreground and background colors.",
            fullDescription: """
Increase Contrast enhances the visual distinction between foreground and background elements, making text and controls easier to see and read.

When enabled:
• Borders and dividers become more prominent
• Button backgrounds become more opaque
• Text contrast is improved
• Subtle UI elements become more visible

This helps users with:
• Low vision
• Age-related vision changes
• Situational impairments (bright sunlight, screen glare)

**WCAG Contrast Requirements:**
• AA: 4.5:1 for normal text, 3:1 for large text
• AAA: 7:1 for normal text, 4.5:1 for large text (recommended with this setting)

**For Developers:**
• Use semantic colors that automatically increase contrast
• Check UIAccessibility.darkerSystemColorsEnabled
• Increase stroke widths and border opacity when enabled
• Test with both standard and increased contrast
• Aim for WCAG AAA standards when this setting is on
""",
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .systemGray,
            activationSteps: [
                "Open Settings app",
                "Go to Accessibility",
                "Tap Display & Text Size",
                "Toggle Increase Contrast ON"
            ],
            category: .vision
        ),
        AccessibilityFeature(
            name: "Reduced Motion",
            icon: "figure.walk",
            shortDescription: "Minimize or disable animations and visual effects.",
            fullDescription: """
Reduce Motion minimizes or removes animations and motion effects throughout the system and apps. This is crucial for users with vestibular disorders, motion sensitivity, or those who find animations distracting.

When enabled:
• Parallax effects are disabled
• Screen transitions become simpler (crossfade instead of zoom/slide)
• Auto-playing videos may be paused
• Animated stickers appear as static images
• App animations are simplified or removed

Who benefits:
• Users with vestibular disorders (vertigo, dizziness)
• Users prone to motion sickness
• Users with seizure disorders
• Users with ADHD or autism who find motion distracting
• Anyone who prefers a calmer interface

**For Developers:**
• Always respect UIAccessibility.isReduceMotionEnabled
• Replace animations with instant transitions or simple crossfades
• Disable auto-play for videos and animated content
• Use static alternatives for animated images
• Test your app with Reduce Motion enabled
• Consider providing a "skip animation" option for all users
""",
            platforms: ["iOS", "iPadOS", "macOS", "watchOS", "tvOS", "visionOS"],
            color: .systemTeal,
            activationSteps: [
                "Open Settings app",
                "Go to Accessibility",
                "Tap Motion",
                "Toggle Reduce Motion ON"
            ],
            category: .motion
        ),
        AccessibilityFeature(
            name: "Captions",
            icon: "text.bubble.fill",
            shortDescription: "Display text synchronized with audio and video content.",
            fullDescription: """
Closed captions and subtitles provide time-synchronized text for audio content in videos. They're essential for deaf and hard-of-hearing users, and helpful for everyone.

Types of captions:
• **Closed Captions (CC):** Include dialogue, sound effects, and speaker identification
• **Subtitles for the Deaf and Hard of Hearing (SDH):** Similar to CC, with additional context
• **Standard Subtitles:** Usually just translate dialogue to another language

When to use captions:
• All video content should have captions
• Live streams can use auto-generated captions
• Educational content benefits greatly from accurate captions
• Social media videos (often watched with sound off)

**For Developers:**
• Use AVPlayer's built-in caption support
• Provide caption tracks with your video content
• Support user caption styling preferences
• Ensure captions are synchronized accurately with audio
• Include sound effects and speaker identification in captions
• Test caption display at various text sizes
""",
            platforms: ["iOS", "iPadOS", "macOS", "tvOS", "visionOS"],
            color: .systemPink,
            activationSteps: [
                "Open Settings app",
                "Go to Accessibility",
                "Tap Subtitles & Captioning",
                "Toggle Closed Captions + SDH ON",
                "Customize Style for appearance preferences"
            ],
            category: .hearing
        ),
        AccessibilityFeature(
            name: "Audio Descriptions",
            icon: "speaker.wave.2.fill",
            shortDescription: "Narration that describes visual elements in video content.",
            fullDescription: """
Audio descriptions provide spoken narration of important visual elements in video content. The narrator describes actions, settings, costumes, and other visual information during natural pauses in dialogue.

What gets described:
• **Characters:** Who's on screen, their appearance, expressions
• **Settings:** Where the scene takes place
• **Actions:** Physical movements, gestures, and activities
• **Emotions:** Facial expressions and body language
• **Text and Graphics:** On-screen text, titles, or visual information

Who benefits:
• Blind and low-vision users
• Users who need to multitask
• Anyone who wants more context about visual content

**For Developers:**
• Use AVPlayer's media selection for audio description tracks
• Check for .describesVideoForAccessibility media characteristic
• Provide audio description tracks for video content
• Auto-select audio description track when user has enabled this feature
• Ensure proper synchronization with video content
• Test that audio descriptions can be toggled without restarting video
""",
            platforms: ["iOS", "iPadOS", "macOS", "tvOS", "visionOS"],
            color: .systemRed,
            activationSteps: [
                "Open Settings app",
                "Go to Accessibility",
                "Tap Audio Descriptions",
                "Toggle Audio Descriptions ON"
            ],
            category: .hearing
        )
    ]

    // MARK: - Helper Methods

    static func features(for category: AccessibilityCategory) -> [AccessibilityFeature] {
        return allFeatures.filter { $0.category == category }
    }

    static func feature(withName name: String) -> AccessibilityFeature? {
        return allFeatures.first { $0.name == name }
    }
}

// MARK: - Hashable Conformance
extension AccessibilityFeature {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: AccessibilityFeature, rhs: AccessibilityFeature) -> Bool {
        return lhs.id == rhs.id
    }
}
