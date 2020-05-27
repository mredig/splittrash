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

	init(masterCoordinator: MasterCoordinator = MasterCoordinator(),
		 detailCoordinator: DetailCoordinator = DetailCoordinator(),
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
		setup(detailCoordinator: detailCoordinator, with: ("White", .white))

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
		setup(detailCoordinator: newDetail, with: namedColor)

		splitViewController.showDetailViewController(detailCoordinator.navigationController, sender: nil)
		splitShouldCollapse = false
	}

	func setup(detailCoordinator: DetailCoordinator, with color: NamedColor) {
		self.detailCoordinator = detailCoordinator
		childCoordinators.append(detailCoordinator)
		detailCoordinator.parentCoordinator = self
		detailCoordinator.start()

		let newVC = detailCoordinator.detailVC
		newVC.view.backgroundColor = color.color
		newVC.navigationItem.title = color.name
		newVC.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
		newVC.navigationItem.leftItemsSupplementBackButton = true
	}
}

extension SplitCoordinator: UISplitViewControllerDelegate {
	func splitViewController(_ splitViewController: UISplitViewController,
							 collapseSecondary secondaryViewController: UIViewController,
							 onto primaryViewController: UIViewController) -> Bool {
		splitShouldCollapse
	}


}
