//
//  SplitCoordinator.swift
//  splittrash
//
//  Created by Michael Redig on 5/26/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

class SplitCoordinator: CoordinatorBase {
	var childCoordinators: [CoordinatorBase] = []

	let splitViewController: UISplitViewController

	let masterCoordinator: MasterCoordinator
	var detailCoordinator: DetailCoordinator

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
		masterCoordinator.parentCoordinator = self
		masterCoordinator.start()
		childCoordinators.append(detailCoordinator)
		detailCoordinator.parentCoordinator = self
		detailCoordinator.start()

		splitViewController.viewControllers = [masterCoordinator.navigationController, detailCoordinator.navigationController]
	}
}

extension SplitCoordinator: CoordinatorParent {
	func childDidFinish(child: CoordinatorBase) {
		for (index, coordinator) in childCoordinators.enumerated() {
			if coordinator === child {
				childCoordinators.remove(at: index)
				break
			}
		}
	}
}

// Master Coordinator Implementations
extension SplitCoordinator {
	func touchedColor(namedColor: NamedColor) {
		detailCoordinator.finish()

		let newDetail = DetailCoordinator()
		newDetail.parentCoordinator = self
		childCoordinators.append(newDetail)
		detailCoordinator = newDetail
		detailCoordinator.start()

		splitShouldCollapse = false
		let newVC = detailCoordinator.detailVC
		newVC.view.backgroundColor = namedColor.color
		newVC.navigationItem.title = namedColor.name

		splitViewController.showDetailViewController(detailCoordinator.navigationController, sender: nil)
	}
}

extension SplitCoordinator: UISplitViewControllerDelegate {
	func splitViewController(_ splitViewController: UISplitViewController,
							 collapseSecondary secondaryViewController: UIViewController,
							 onto primaryViewController: UIViewController) -> Bool {
		splitShouldCollapse
	}
}
