//
//  TheTableViewC.swift
//  splittrash
//
//  Created by Michael Redig on 5/26/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

class TheTableViewC: UITableViewController {
	let colors: [UIColor] = [.red, .blue, .magenta, .systemPink, .systemTeal]

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Select Color"

		configureTableView()
	}

	private func configureTableView() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}

}

extension TheTableViewC {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		colors.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = colors.description

		return cell
	}

//	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		<#code#>
//	}
}
