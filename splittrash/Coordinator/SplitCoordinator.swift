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
	let detailNavControllerGenerator: () -> UINavigationController
	var detailNavController: UINavigationController
	let splitViewController: UISplitViewController

	var splitShouldCollapse = true

	init(masterNavController: UINavigationController = UINavigationController(),
		 detailNavControllerGenerator: @escaping () -> UINavigationController = { UINavigationController() },
		 splitViewController: UISplitViewController = UISplitViewController()) {
		self.masterNavController = masterNavController
		self.detailNavControllerGenerator = detailNavControllerGenerator
		self.detailNavController = detailNavControllerGenerator()
		self.splitViewController = splitViewController

		splitViewController.delegate = self
	}

	func start() {
		setupMasterVC()
		setupDetailVC(with: ("White", .white))

		splitViewController.viewControllers = [masterNavController, detailNavController]
		splitViewController.preferredDisplayMode = .allVisible
	}

	func setupMasterVC() {
		let masterVC = ColorTableView()
		masterVC.coordinator = self
		masterNavController.pushViewController(masterVC, animated: false)
	}

	func setupDetailVC(with color: NamedColor) {
		let newVC = DetailColorVC()
		newVC.view.backgroundColor = color.color
		newVC.navigationItem.title = color.name
		newVC.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
		newVC.navigationItem.leftItemsSupplementBackButton = true

		detailNavController = detailNavControllerGenerator()
		detailNavController.pushViewController(newVC, animated: false)
		splitViewController.showDetailViewController(detailNavController, sender: self)
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

		setupDetailVC(with: namedColor)
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
