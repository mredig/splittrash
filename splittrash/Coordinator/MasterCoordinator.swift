//
//  MasterCoordinator.swift
//  splittrash
//
//  Created by Michael Redig on 5/27/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

class MasterCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []

	let navigationController: UINavigationController
	let masterViewController: TheTableViewC

	init(masterNavigationController: UINavigationController = UINavigationController()) {
		self.navigationController = masterNavigationController
		masterViewController = TheTableViewC()
		masterViewController.coordinator = self
	}

	func start() {
		navigationController.pushViewController(masterViewController, animated: false)
	}
}

extension MasterCoordinator: TheTableViewCCoordinator {
	
}
