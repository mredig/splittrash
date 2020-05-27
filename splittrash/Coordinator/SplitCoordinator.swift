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

	let masterNavController: UINavigationController
	let splitViewController: UISplitViewController

	var detailCoordinator: DetailCoordinator

	var splitShouldCollapse = true

	init(masterNavController: UINavigationController = UINavigationController(),
		 detailCoordinator: DetailCoordinator = DetailCoordinator(),
		 splitViewController: UISplitViewController = UISplitViewController()) {
		self.masterNavController = masterNavController
		self.detailCoordinator = detailCoordinator
		self.splitViewController = splitViewController

		splitViewController.delegate = self
	}

	func start() {
		setupMasterVC()
		setup(detailCoordinator: detailCoordinator, with: ("White", .white))

		splitViewController.viewControllers = [masterNavController, detailCoordinator.navigationController]
		splitViewController.preferredDisplayMode = .allVisible
	}


	func setupMasterVC() {
		let masterVC = ColorTableView()
		masterVC.coordinator = self
		masterNavController.pushViewController(masterVC, animated: false)
	}

	/// Despite what the docs say SHOULD happen when you call `showDetailViewController` (if theres a nav controller,
	/// it should push the new VC onto the stack), it simply goes dumb and replaces whatever the detail vc is with the
	/// new vc. Therefore, we need to supply a brand new nav controller *every time*. Might as well just give it a whole
	/// new coordinator too while we are at it.
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
extension SplitCoordinator: TheTableViewCCoordinator {
	func touchedColor(namedColor: NamedColor) {
		detailCoordinator.finish()

		let newDetail = DetailCoordinator()
		setup(detailCoordinator: newDetail, with: namedColor)

		splitViewController.showDetailViewController(detailCoordinator.navigationController, sender: nil)
		splitShouldCollapse = false
	}

}

extension SplitCoordinator: UISplitViewControllerDelegate {
	func splitViewController(_ splitViewController: UISplitViewController,
							 collapseSecondary secondaryViewController: UIViewController,
							 onto primaryViewController: UIViewController) -> Bool {
		splitShouldCollapse
	}

	func targetDisplayModeForAction(in svc: UISplitViewController) -> UISplitViewController.DisplayMode {
		svc.displayMode == .allVisible ? .primaryHidden : .allVisible
	}
}
