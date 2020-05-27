//
//  SplitCoordinator.swift
//  splittrash
//
//  Created by Michael Redig on 5/26/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

class SplitCoordinator: CoordinatorBase {
	var childCoordinators: [Coordinator] = []

	let splitViewController: UISplitViewController

	let masterCoordinator: MasterCoordinator
	let detailCoordinator: DetailCoordinator

	var splitShouldCollapse = true

	init(masterCoordinator: MasterCoordinator,
		 detailCoordinator: DetailCoordinator,
		 splitViewController: UISplitViewController = UISplitViewController()) {
		self.masterCoordinator = masterCoordinator
		self.detailCoordinator = detailCoordinator
		self.splitViewController = splitViewController

		splitViewController.delegate = self
	}

	func start() {
		childCoordinators.append(masterCoordinator)
		masterCoordinator.start()
		childCoordinators.append(detailCoordinator)
		detailCoordinator.start()

		splitViewController.viewControllers = [masterCoordinator.navigationController, detailCoordinator.navigationController]
	}
}

extension SplitCoordinator: UISplitViewControllerDelegate {
	func splitViewController(_ splitViewController: UISplitViewController,
							 collapseSecondary secondaryViewController: UIViewController,
							 onto primaryViewController: UIViewController) -> Bool {
		splitShouldCollapse
	}
}
