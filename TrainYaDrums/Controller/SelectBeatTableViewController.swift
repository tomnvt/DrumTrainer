//
//  SelectBeatTableViewController.swift
//  DrumTrainer
//
//  Created by NVT on 11.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit
import RealmSwift

class SelectBeatTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var beatsTableView: UITableView!

    let realm = try! Realm()
    var savedBeatsNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        beatsTableView.dataSource = self
        beatsTableView.delegate = self
        getBeatsNames()
    }

    func getBeatsNames() {
        let beats = realm.objects(ExampleBeat.self)
        for beat in beats {
            savedBeatsNames.append(beat.name)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedBeatsNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = savedBeatsNames[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Beat with name '\(savedBeatsNames[indexPath.row])' selected.")
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
