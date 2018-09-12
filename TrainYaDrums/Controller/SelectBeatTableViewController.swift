//
//  SelectBeatTableViewController.swift
//  DrumTrainer
//
//  Created by NVT on 11.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

class SelectBeatTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var beatsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Save")
        beatsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
