//
//  SplitCoordinator.swift
//  splittrash
//
//  Created by Michael Redig on 5/26/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

class SplitCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []
	let navigationController: UINavigationController
	let masterNavigationController: UINavigationController
	var detailNavigationController: UINavigationController {
		navigationController
	}
	let masterViewController: UIViewController
	let detailViewController: UIViewController
	let splitViewController: UISplitViewController

	var splitShouldCollapse = true

	init(masterViewController: UIViewController,
		 masterNavigationController: UINavigationController = UINavigationController(),
		 detailViewController: UIViewController,
		 detailNavigationController: UINavigationController = UINavigationController(),
		 splitViewController: UISplitViewController = UISplitViewController()) {
		navigationController = detailNavigationController
		self.masterNavigationController = masterNavigationController
		self.splitViewController = splitViewController
		self.masterViewController = masterViewController
		self.detailViewController = detailViewController

		splitViewController.delegate = self
	}

	func start() {
		navigationController.pushViewController(detailViewController, animated: false)
		masterNavigationController.pushViewController(masterViewController, animated: false)

		splitViewController.viewControllers = [masterNavigationController, navigationController]
	}
}

extension SplitCoordinator: UISplitViewControllerDelegate {
	func splitViewController(_ splitViewController: UISplitViewController,
							 collapseSecondary secondaryViewController: UIViewController,
							 onto primaryViewController: UIViewController) -> Bool {
		splitShouldCollapse
	}
}
