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
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        beatsTableView.dataSource = self
        beatsTableView.delegate = self
        getBeatsNames()
        beatsTableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .middle)
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " Beats"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = savedBeatsNames[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 255, green: 226, blue: 84)
        cell.selectedBackgroundView = bgColorView
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Beat with name '\(savedBeatsNames[indexPath.row])' selected.")
        ExamplePlayer.exampleBeatNotes = BeatNotesLoader.getNotesFor(exampleBeatName: savedBeatsNames[indexPath.row],
                                                                     beatIndex: 0)
        defaults.set(savedBeatsNames[indexPath.row], forKey: "currentlySelectedBeatName")
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add new beat",
                                      message: "Do you want to duplicate current beat or create an empty one?",
                                      preferredStyle: .alert)
        let duplicate = UIAlertAction(title: "Duplicate", style: .default, handler: nil)
        let createEmpty = UIAlertAction(title: "Empty beat", style: .default, handler: { _ in
            ExamplePlayer.exampleBeatNotes = EmptyExampleBeat.exampleBeatNotes
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
