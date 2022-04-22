//
//  StartsTableViewController.swift
//  SpaceX
//
//  Created by Alex Ch. on 14.04.2022.
//

import UIKit

class StartsTableViewController: UITableViewController {

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? StartsTableViewCell {
            
            cell.NameOfRocket.text = "Falcon 1"
            cell.date.text = "123131"
            
        }
        return UITableViewCell()
    }
}
