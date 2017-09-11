# DirectLine
[![CocoaPods](https://img.shields.io/cocoapods/v/DirectLine.svg)](https://cocoapods.org/pods/DirectLine)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platforms](https://img.shields.io/cocoapods/p/DirectLine.svg)](https://cocoapods.org/pods/DirectLine)

**DirectLine** is a client library for the Microsoft Bot Framework [Direct Line](https://docs.microsoft.com/en-us/bot-framework/rest-api/bot-framework-rest-direct-line-3-0-concepts) protocol.

Loosely based on the official [Javascript DirectLine client](https://github.com/Microsoft/BotFramework-DirectLineJS), it enables communication between your bot and your iOS app using a simple [ReactiveX](https://github.com/ReactiveX/RxSwift) based interface.

## Examples
To create a `DirectLine` object, you must provide either the secret for your bot or a temporary token obtained via the [Generate Token](https://docs.microsoft.com/en-us/bot-framework/rest-api/bot-framework-rest-direct-line-3-0-api-reference#generate-token) API:

```swift
import DirectLine

let directLine = DirectLine(token: "f1STR0.p3c4D0r") 
```

**DirectLine** manages token renewal and web socket connection under the hood, so you don't have to worry about them.

Post activities to the bot:

```swift
let myAccount = ChannelAccount(id: "myUserID", name: "Guille")
directLine
	.post(activity: Activity(from: myAccount, text: "What is my current balance?"))
	.subscribe(
		onNext: { print("Posted activity, assigned ID (\($0.id)") },
		onError: { print("Error posting activity \($0)") }
	)
```

Listen to activities sent and received from the bot:

```swift
directLine.activities
	.subscribe(onNext: { activity in
		print("Received activity \(activity)")
	})
```

You can leverage Rx operators on the incoming activities. For instance, to see only `message` activities:

```swift
directLine.activities
	.filter { $0.type == .message }
	.subscribe(onNext: { activity in
		print("Received message \(activity)")
	})
```

The `activities` stream includes those sent to the bot, so a common patter is to filter them out using the `from` property:

```swift
directLine.activities
	.filter { $0.type == .message  && $0.from.id == "yourBotHandle" }
	.subscribe(onNext: { activity in
		print("Received message from the bot \(activity)")
	})
```

## Installation
**Using CocoaPods**

Add `pod DirectLine` to your `Podfile`

**Using Carthage**

Add `git "gonzalezreal/DirectLine"` to your `Cartfile`

**Using the Swift Package Manager**

Add `Package(url: "https://github.com/gonzalezreal/DirectLine.git", majorVersion: 1)` to your `Package.swift` file.

## Help & Feedback
- [Open an issue](https://github.com/gonzalezreal/DirectLine/issues/new) if you need help, if you found a bug, or if you want to discuss a feature request.
- [Open a PR](https://github.com/gonzalezreal/DirectLine/pull/new/master) if you want to make some change to `DirectLine`.
- Contact [@gonzalezreal](https://twitter.com/gonzalezreal) on Twitter.
