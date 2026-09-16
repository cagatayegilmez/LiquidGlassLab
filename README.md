# LiquidGlassLab
Liquid Glass webinar demo.
- Used Swift 6 language
- Used Tuist for modulating project
- Used SwiftUI and UIKit for UI designs
- Used Swift Concurrency
- Used iOS 26 Liquid Glass APIs with iOS 18 fallbacks
- Used iOS 27 toolbar and tab APIs behind availability checks
- No third party libraries needed

Modules:

1. DesignKit;

Glass wrappers, tokens, the demo screen catalog and the observation helper shared by both showcases

2. SwiftUIShowcase;

Portfolio, Market, Trade and Search demo tabs plus the Lab tab built with SwiftUI

3. UIKitShowcase;

The same tabs built with UIKit, every screen split into View, ViewModel, ViewModelProtocol and ViewController; below iOS 26 a custom glass capsule tab bar stands in for the native one

## Requirements

- Xcode 27.0
- mise
- SwiftLint

## Installation

Clone the repo:

```
git clone https://github.com/cagatayegilmez/LiquidGlassLab.git
```

Go to the project folder:

```
cd yourFolder/LiquidGlassLab
```

Install the pinned Tuist:

```
mise install
```

Fetch the dependencies:

```
tuist install
```

Generate the project:

```
tuist generate
```

Note: This project uses SwiftLint, so SwiftLint must be installed on your machine to build the project.

## License

Apache
