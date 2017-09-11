import PackageDescription

let package = Package(
    name: "DirectLine",
    dependencies: [
		.Package(url: "https://github.com/ReactiveX/RxSwift.git", majorVersion: 4, minor: 0),
		.Package(url: "https://github.com/daltoniam/Starscream.git", majorVersion: 2, minor: 0),
		.Package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", majorVersion: 6, minor: 0)
	]
)
