//
//  SelectBeatTableViewController.swift
//  DrumTrainer
//
//  Created by NVT on 11.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class SelectBeatTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    SwipeTableViewCellDelegate {

    private enum Constants {
        static let CellIdentifier = "Cell"
    }

    @IBOutlet weak var beatsTableView: UITableView!

    let realm = try! Realm()
    var savedBeatsNames: [String] = []
    weak var delegate: EmptyBeatCreatorDelegate?
    let defaults = UserDefaults.standard
    var indexOfOrinallySelectedBeat: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        beatsTableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifier)
        beatsTableView.dataSource = self
        beatsTableView.delegate = self
        getBeatsNames()
        getIndexOfOrinallySelectedBeat()
        selectCellForBeat(withBeatIndex: indexOfOrinallySelectedBeat)
    }

    func getIndexOfOrinallySelectedBeat() {
        indexOfOrinallySelectedBeat = BeatNotesLoader.getIndexOfCurrentlySelectedBeat()
    }

    func selectCellForBeat(withBeatIndex: Int) {
        beatsTableView.selectRow(at: IndexPath.init(row: withBeatIndex,
                                                    section: 0),
                                                    animated: true,
                                                    scrollPosition: .middle)
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
        return "\tBeats"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 50)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier, for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = savedBeatsNames[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.delegate = self
        if cell.isSelected {
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ExamplePlayer.exampleBeatNotes = BeatNotesLoader
            .getNotesFor(exampleBeatName: savedBeatsNames[indexPath.row], beatIndex: 0)
        defaults.set(savedBeatsNames[indexPath.row], forKey: UserDefaultsKeys.currentlySelectedBeatName.rawValue)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        beatsTableView.cellForRow(at: indexPath)?.textLabel?.font = .boldSystemFont(ofSize: 15)
    }

    // TODO: Make deletion safe for BeatEditView
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard indexPath.row > 1 else { return nil }
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive,
                                       title: "Delete") { _, indexPath in
                                        BeatNotesDeleter.deleteExampleBeat(name: self.savedBeatsNames[indexPath.row])
                                        self.savedBeatsNames.remove(at: indexPath.row)
        }
        return [deleteAction]
    }

    func tableView(_ tableView: UITableView,
                   editActionsOptionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        ExamplePlayer.exampleBeatNotes = BeatNotesLoader.getNotesFor(exampleIndex: indexOfOrinallySelectedBeat,
                                                                     beatIndex: 0)
        defaults.set(savedBeatsNames[indexOfOrinallySelectedBeat],
                     forKey: UserDefaultsKeys.currentlySelectedBeatName.rawValue)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add new beat",
                                      message: "Do you want to duplicate current beat or create an empty one?",
                                      preferredStyle: .alert)
        let duplicateBeat = UIAlertAction(title: "Duplicate", style: .default, handler: { _ in
            self.callDelegateAndDismissView()
        })
        let createEmptyBeat = UIAlertAction(title: "Empty beat", style: .default, handler: { _ in
            ExamplePlayer.exampleBeatNotes = EmptyExampleBeat.exampleBeatNotes
            self.callDelegateAndDismissView()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil )
        alert.addAction(duplicateBeat)
        alert.addAction(createEmptyBeat)
        alert.addAction(cancel)
        self.show(alert, sender: nil)
    }

    func callDelegateAndDismissView() {
        delegate?.createNewBeat()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func chooseButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

protocol EmptyBeatCreatorDelegate: AnyObject {
    func createNewBeat()
}
