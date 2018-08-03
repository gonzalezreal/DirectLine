//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import DirectLine
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	private let window = UIWindow(frame: UIScreen.main.bounds)

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let conversationPresenter = ConversationPresenter(directLine: DirectLine(token: AppConstants.botSecretOrToken))
		let conversationViewController = ConversationViewController(conversationPresenter: conversationPresenter)
		conversationViewController.title = "DirectLine Sample"

		window.rootViewController = UINavigationController(rootViewController: conversationViewController)
		window.makeKeyAndVisible()

		return true
	}
}
