# UIKit Accessibility Lab Guide

Welcome to the UIKit version of the accessibility lab. This guide mirrors the progressive uncommenting approach you used in SwiftUI, but each exercise now maps directly to a UIKit view controller with numbered `// TODO #…` markers.

## Getting Started

1. **Open** `AccessibilityTestUiKit.xcodeproj` in Xcode 16 or later.
2. **Select** the *AccessibilityTestUiKit* scheme and run the app in the simulator.
3. **Work through the TODOs in order**. Each controller contains the complete solution in comments—uncomment or rewrite as directed and test after every change.
4. **Prefer testing on device or simulator** to feel the accessibility behaviours first-hand.

## Exercise Roadmap

### TODO #1 – VoiceOver Essentials (UIKit)
- **File**: `AccessibilityTestUiKit/VoiceOverTestViewController.swift`
- **Focus**: Descriptive labels, hints, values, and announcements for buttons, grouped weather cards, and sliders.
- **Test**: Turn on VoiceOver (Settings → Accessibility → VoiceOver). Swipe through the counter, like button, weather card, and volume slider. Confirm the announcements match the instructions.

### TODO #2 – Dynamic Type & Larger Text
- **File**: `AccessibilityTestUiKit/LargerTextTestViewController.swift`
- **Focus**: Detect dynamic type changes, swap between horizontal/vertical stacks, and hide decorative icons at accessibility sizes.
- **Test**: Settings → Accessibility → Display & Text Size → Larger Text. Enable “Larger Accessibility Sizes” and drag the slider to the maximum value. Revisit the screen to verify the layout adapts.

### TODO #3 – Dark Mode & Contrast
- **File**: `AccessibilityTestUiKit/DarkInterfaceTestViewController.swift`
- **Focus**: Inspect `traitCollection.userInterfaceStyle`, swap content for light/dark appearances, and choose semantic UIKit colours.
- **Test**: Toggle light/dark appearance via Control Centre or Settings → Display & Brightness. Confirm backgrounds, text, and sample swatches respond correctly.

### TODO #4 – Differentiate Without Colour
- **File**: `AccessibilityTestUiKit/DifferentiateColorTestViewController.swift`
- **Focus**: Detect `UIAccessibility.shouldDifferentiateWithoutColor`, add icons and text labels to colour-coded states, and keep status messages legible.
- **Test**: Settings → Accessibility → Display & Text Size → Differentiate Without Colour. Ensure success/error badges, form validation, and selection states show extra indicators.

### TODO #5 – Reduce Motion
- **File**: `AccessibilityTestUiKit/ReducedMotionTestViewController.swift`
- **Focus**: Respect `UIAccessibility.isReduceMotionEnabled`, fall back to static animations, and remove looping motion when requested.
- **Test**: Settings → Accessibility → Motion → Reduce Motion. Trigger the animation demo; animated elements should calm down or freeze.

### TODO #6 – Voice Control Labels
- **File**: `AccessibilityTestUiKit/VoiceControlTestViewController.swift`
- **Focus**: Give every control a unique accessibility label so Voice Control can target it precisely.
- **Test**: Settings → Accessibility → Voice Control → On. Say “Show names”, then use commands such as “Tap Like” or “Tap Option Three” to ensure each element responds.

### TODO #7 – Adaptive Layouts in Lists & Details
- **Files**:
  - `AccessibilityTestUiKit/ViewController.swift`
  - `AccessibilityTestUiKit/AccessibilityDetailViewController.swift`
- **Focus**: Hide decorative copy at accessibility sizes, adjust constraints for large text, and keep content focused on core information.
- **Test**: With text at the largest accessibility size, browse the feature list and detail screens. Decorative icons and footers should disappear, and spacing should remain comfortable.

## Tips While Working Through the Lab

- **Uncomment intentionally**: Tackle one TODO block at a time, run the app, and verify the change before moving on.
- **Prefer semantic colours and fonts**: UIKit’s `UIColor` and `UIFont` convenience APIs automatically adapt to contrast, dynamic type, and appearance changes.
- **Listen as well as look**: Many exercises include VoiceOver announcements—test with audio enabled to catch mistakes quickly.
- **Document your observations**: Each exercise includes a reflective question in the project’s comments. Capture your answers for discussion.

## Need a Refresher?

- Apple’s **Human Interface Guidelines** on Accessibility
- Xcode’s **Accessibility Inspector** (Xcode → Open Developer Tool → Accessibility Inspector)
- WWDC sessions on VoiceOver, Dynamic Type, and reduce motion best practice

Happy shipping—accessibility improvements help every learner in the room.
