//
//  ViewController.swift
//  splittrash
//
//  Created by Michael Redig on 5/26/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {




	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
		navigationItem.leftItemsSupplementBackButton = true
	}


}

