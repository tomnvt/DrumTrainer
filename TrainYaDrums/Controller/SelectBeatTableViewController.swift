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
    weak var delegate: EmptyBeatCreatorDelegate?

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
        ExamplePlayer.exampleBeatNotes = BeatNotesLoader.getNotesFor(exampleBeatName: savedBeatsNames[indexPath.row],
                                                                     beatIndex: 0)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add new beat",
                                      message: "Do you want to duplicate current beat or create an empty one?",
                                      preferredStyle: .alert)
        let duplicate = UIAlertAction(title: "Duplicate", style: .default, handler: nil)
        let createEmpty = UIAlertAction(title: "Empty beat", style: .default, handler: { action in
            self.delegate?.createEmptyBeat()
            self.dismiss(animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil )
        alert.addAction(duplicate)
        alert.addAction(createEmpty)
        alert.addAction(cancel)
        self.show(alert, sender: nil)
    }

    func createEmptyBeat() {
        delegate?.createEmptyBeat()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func chooseButtonPressed(_ sender: UIButton) {
    }

}

protocol EmptyBeatCreatorDelegate: AnyObject {
    func createEmptyBeat()
}
