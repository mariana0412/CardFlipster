# CardFlipster

CardFlipster is a customizable SwiftUI framework that makes building flashcard-based learning apps both simple and captivating. 
With smooth card-flipping animations, progress tracking via a built-in progress bar, and the ability to retry incorrect flashcards, 
it offers a dynamic learning experience. Whether using predefined themes or customizing every detail, CardFlipster empowers developers 
to create visually stunning and interactive applications.

## Features

- <b>Predefined Themes:</b> Includes ready-to-use Light and Dark themes for quick setup
- <b>Custom Themes:</b> Offers full flexibility to customize the appearance of flashcards and the statistics screen, including colors, fonts, and texts
- <b>Flip Animation:</b> Flashcards include a smooth horizontal flip animation when tapped
- <b>Interactive Flashcards:</b> Features intuitive swipe gestures — swipe right to mark as correct, swipe left to mark as incorrect — along with dedicated "checkmark" and "cross" buttons for marking answers
- <b>Progress Tracking:</b> Displays a progress bar indicating how many flashcards have been already reviewed and their total number
- <b>Round Summary:</b> After each round, view statistics on your progress, including the number of flashcards learned and those marked as incorrect
- <b>Restart with Incorrect Cards:</b> Start a new round with only the flashcards that were marked as incorrect

## Requirements

- iOS 15.0 or later
- Xcode 15.0 or later
- Swift 5.5 or later

## Installation
### Swift Package Manager (SPM)
1. Open your Xcode project
2. Go to File -> Add Packages
3. In the search bar, paste the GitHub repository URL:
```bash
https://github.com/mariana0412/CardFlipster.git
```
5. Choose the latest version or specify a version range if necessary
6. Click Add Package to integrate the framework into your project

### Cocoapods
1. Install CocoaPods (if not already installed)  
Using RubyGems:
```bash
sudo gem install cocoapods
```
Or using Homebrew:
```bash
brew install cocoapods
```
2. Initialize CocoaPods in your project - navigate to your project's root directory in the terminal and run:
```ruby
pod init
```
3. Open the newly created Podfile in your project directory and add the following line under your target:
```ruby
pod 'CardFlipster', '~> 1.0.0'
```
4. Install the Pod - save the Podfile and run the following command in the terminal:
```ruby
pod install
```
5. After installation completes, open the newly created .xcworkspace file in Xcode instead of your .xcodeproj.

## Usage

### 1. Import the Framework
To get started, import the framework into your Swift file:
```swift
import CardFlipster
```

### 2. Define the flashcards
Create an array of flashcards using the Flashcard structure:
```swift
let flashcards: [Flashcard] = [
    Flashcard(frontText: "What is the capital of Ukraine?", backText: "Kyiv"),
    Flashcard(frontText: "What is the capital of France?", backText: "Paris"),
    Flashcard(frontText: "What is the capital of Italy?", backText: "Rome")
]
```

### 3. Create a Flashcard Deck View
#### a. Use a Predefined Theme (.light or .dark)
```swift
FlashcardDeckView(flashcards: flashcards, theme: .dark)
```
#### b. Use a Customized Theme

For a fully personalized appearance, define a custom theme by configuring the flashcards and statistics screens separately.

##### i. Customize Flashcards Appearance
Use FlashcardUIConfig to define how the flashcards should look:

```swift
let flashcardConfig = FlashcardUIConfig(
    frontColor: .purple,
    backColor: .pink,
    font: .title,
    frontFontColor: .white,
    backFontColor: .white,
    progressBarColor: .pink
)
```

##### ii. Customize Statistics Screen Appearance
Use StatisticsScreenUIConfig to style the statistics screen:
```swift
let statisticsConfig = StatisticsScreenUIConfig(
    backgroundColor: LinearGradient(
        gradient: Gradient(colors: [.purple, .pink]),
        startPoint: .top,
        endPoint: .bottom
    ),
    titleFont: .largeTitle,
    subtitleFont: .headline,
    textColor: .white,
    buttonBackgroundColor: .purple,
    buttonTextColor: .white
)
```

##### iii. Combine Configurations to Create a Custom Theme
Use FlashcardDeckUIConfig to bring together the flashcard and statistics screen customizations:
```swift
FlashcardDeckView(
    flashcards: flashcards,
    theme: .custom(FlashcardDeckUIConfig(
        flashcardConfig: flashcardConfig,
        statisticsConfig: statisticsConfig)
    )
)
```

## Examples
### Using Predefined Themes
This example demonstrates how to use a predefined dark theme for the flashcard deck:
```swift
import SwiftUI
import CardFlipster

struct CardFlipsterDarkTheme: View {
    
    let flashcards: [Flashcard] = [
        Flashcard(frontText: "What is the capital of Ukraine?", backText: "Kyiv"),
        Flashcard(frontText: "What is the capital of France?", backText: "Paris"),
        Flashcard(frontText: "What is the capital of Italy?", backText: "Rome")
    ]

    
    var body: some View {
        FlashcardDeckView(flashcards: flashcards, theme: .dark)
    }
}
```

### Using Custom Themes
This example showcases how to create a custom theme by specifying the appearance for both flashcards and statistics:
```swift
import SwiftUI
import CardFlipster

struct CardFlipsterCustomTheme: View {
    
    let flashcards: [Flashcard] = [
        Flashcard(frontText: "What is the capital of Ukraine?", backText: "Kyiv"),
        Flashcard(frontText: "What is the capital of France?", backText: "Paris"),
        Flashcard(frontText: "What is the capital of Italy?", backText: "Rome")
    ]

    let flashcardConfig = FlashcardUIConfig(
        frontColor: .purple,
        backColor: .pink,
        font: .title,
        frontFontColor: .white,
        backFontColor: .white,
        progressBarColor: .pink
    )

    let statisticsConfig = StatisticsScreenUIConfig(
        backgroundColor: LinearGradient(
            gradient: Gradient(colors: [.purple, .pink]),
            startPoint: .top,
            endPoint: .bottom
        ),
        titleFont: .largeTitle,
        subtitleFont: .headline,
        textColor: .white,
        buttonBackgroundColor: .purple,
        buttonTextColor: .white
    )

    var body: some View {
        FlashcardDeckView(
            flashcards: flashcards,
            theme: .custom(FlashcardDeckUIConfig(
                flashcardConfig: flashcardConfig,
                statisticsConfig: statisticsConfig)
            )
        )
    }
}
```

## License
CardFlipster is licensed under the [MIT License](https://github.com/mariana0412/CardFlipster/blob/main/LICENSE).
