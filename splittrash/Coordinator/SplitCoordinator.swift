//
//  SplitCoordinator.swift
//  splittrash
//
//  Created by Michael Redig on 5/26/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

class SplitCoordinator {
	var childCoordinators: [Coordinator] = []
	let navigationController: UINavigationController
	var detailNavigationController: UINavigationController {
		navigationController
	}
	let detailViewController: UIViewController
	let splitViewController: UISplitViewController
	let masterCoordinator: MasterCoordinator

	var splitShouldCollapse = true

	init(masterCoordinator: MasterCoordinator,
		 detailViewController: UIViewController,
		 detailNavigationController: UINavigationController = UINavigationController(),
		 splitViewController: UISplitViewController = UISplitViewController()) {
		self.masterCoordinator = masterCoordinator
		navigationController = detailNavigationController
		self.splitViewController = splitViewController
		self.detailViewController = detailViewController

		splitViewController.delegate = self
	}

	func start() {
		childCoordinators.append(masterCoordinator)
		masterCoordinator.start()
		navigationController.pushViewController(detailViewController, animated: false)

		splitViewController.viewControllers = [masterCoordinator.navigationController, navigationController]
	}
}

extension SplitCoordinator: UISplitViewControllerDelegate {
	func splitViewController(_ splitViewController: UISplitViewController,
							 collapseSecondary secondaryViewController: UIViewController,
							 onto primaryViewController: UIViewController) -> Bool {
		splitShouldCollapse
	}
}
