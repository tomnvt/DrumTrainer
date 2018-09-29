//
//  BeatEditViewController.swift
//  DrumTrainer
//
//  Created by NVT on 08.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit
import CollectionViewGridLayout

class BeatEditViewController: UIViewController, EmptyBeatCreatorDelegate {

    @IBOutlet var collectionView: UICollectionView!
    public var numberOfRows: Int = 16
    private var editingNewBeat: Bool = false
    let deadline = DispatchTime.now() + 1

    var eighthNoteIndex = 0
    var currentBarEighthNoteIndex = 0
    var sectionIndex = 0

    var notes: [[Int]] = []
    let notesListPointers: [[Int]] = {
        var array: [[Int]] = []
        let firstDrumPadNotesIndices = [0, 16, 32, 48, 64, 80, 96, 112]
        for index in 0...15 {
            var multiplicatedFirstDrumPadNotesIndices: [Int] = firstDrumPadNotesIndices.map { $0 + index }
            array.append(multiplicatedFirstDrumPadNotesIndices)
        }
        return array
    }()

    let defaults = UserDefaults.standard

    weak var delegate: NoteChangerDelegate?

    let globalClockBeat = Notification.Name(rawValue: "globalClockBeat")
    let globalClockEighthNote = Notification.Name(rawValue: "eighthNote")

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: String(describing: PathCollectionViewCell.self), bundle: nil),
                                     forCellWithReuseIdentifier: PathCollectionViewCell.identifier)

        self.collectionView.register(UINib(nibName: String(describing: CollectionReusableView.self), bundle: nil),
                                     forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                     withReuseIdentifier: CollectionReusableView.identifier)

        self.collectionView.register(UINib(nibName: String(describing: CollectionReusableView.self), bundle: nil),
                                     forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                     withReuseIdentifier: CollectionReusableView.identifier)
        NotificationCenter.default.addObserver(self, selector: #selector(resetSectionIndex),
                                               name: globalClockBeat, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(animateLoopProgress),
                                               name: globalClockEighthNote, object: nil)
        self.collectionView.allowsMultipleSelection = true
    }

    override func viewWillAppear(_ animated: Bool) {
        selectCollectionCellsForPlayingNotes()
    }

    @objc func animateLoopProgress() {
        if currentBarEighthNoteIndex < 8 {
            currentBarEighthNoteIndex += 1
        } else {
            currentBarEighthNoteIndex = 0
        }
        let sectionIndex = (eighthNoteIndex / 9) + 1
        for index in 0...15 {
            let currentCell = collectionView.cellForItem(at: IndexPath
                .init(row: (16 * currentBarEighthNoteIndex + index),
                      section: (sectionIndex - 1)))
            if currentCell?.isSelected == false {
                currentCell?.yellowBlink()
            }

        }
        if eighthNoteIndex < 31 {
            eighthNoteIndex += 1
        } else {
            eighthNoteIndex = 0
        }
    }

    @objc func resetSectionIndex() {
        if sectionIndex < 3 {
            sectionIndex = 0
        } else {
            sectionIndex += 1
        }
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        if editingNewBeat {
            askIfUserWantToSaveCurrentlyEditedBeat(callerButtonTitle: .back)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func beatsButtonPressed(_ sender: UIButton) {
        if editingNewBeat {
            askIfUserWantToSaveCurrentlyEditedBeat(callerButtonTitle: .beats)
        }
    }

     func selectPlayingCell(_ currentSection: Int, _ currentDrumPad: Int, _ currentNote: Int) {
        let indexPathSection = currentSection
        let indexPathRow = notesListPointers[currentDrumPad][currentNote]
        let indexPathToCell = IndexPath.init(row: indexPathRow, section: indexPathSection)
        collectionView.selectItem(at: indexPathToCell, animated: false, scrollPosition: .left)
    }

    func deselectPlayingCell(_ currentSection: Int, _ currentDrumPad: Int, _ currentNote: Int) {
        let indexPathSection = currentSection
        let indexPathRow = notesListPointers[currentDrumPad][currentNote]
        let indexPathToCell = IndexPath.init(row: indexPathRow, section: indexPathSection)
        collectionView.deselectItem(at: indexPathToCell, animated: false)
    }

    func selectCollectionCellsForPlayingNotes() {
        notes = ExamplePlayer.exampleBeatNotes
        var currentDrumPad = 0
        var currentSection = 0
        var currentNote = 0
        for singleDrumPadNotes in notes {
            for note in singleDrumPadNotes {
                if currentNote == 8 {
                    currentNote = 0
                    currentSection += 1
                }
                if currentSection == 4 {
                    currentSection = 0
                }
                if note == 1 {
                    selectPlayingCell(currentSection, currentDrumPad, currentNote)
                } else if note == 0 {
                    deselectPlayingCell(currentSection, currentDrumPad, currentNote)
                }
                currentNote += 1
            }
            currentDrumPad += 1
        }
    }

    func changeNoteForCell(indexPath: IndexPath) {
        var drumPadIndex = 0
        var drumPadNoteIndex = 0
        for index in 0..<notesListPointers.count {
            if notesListPointers[index].contains(indexPath.row) {
                drumPadIndex = index
                if let noteIndex = notesListPointers[index].index(of: indexPath.row) {
                    drumPadNoteIndex = noteIndex
                }
                break
            }
        }
        var currentNoteValue = notes[drumPadIndex][drumPadNoteIndex]
        notes[drumPadIndex][drumPadNoteIndex] = (currentNoteValue == 1) ? 0 : 1
        currentNoteValue = notes[drumPadIndex][drumPadNoteIndex]
        delegate?.changeNote(drumPadIndex: drumPadIndex, noteIndex: (drumPadNoteIndex + (8 * indexPath.section)))
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if editingNewBeat {
            askForNewBeatNameAndSave(senderButtonTitle: .save)
        } else {
            saveCurrentBeat()
        }
    }

    func saveCurrentBeat() {
        BeatNotesSaver.save(beatNotes: ExamplePlayer.exampleBeatNotes)
        showAlertWithMessageSaved()
    }

    func showAlertWithMessageSaved() {
        let alert = UIAlertController(title: "SAVED :-)", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            alert.dismiss(animated: true, completion: nil)
        }
    }

    func showABeatAlreadyExistsAlert(beatName: String, senderButtonTitle: BeatButtonLabel) {
        let alert = UIAlertController(title: "Can't save :-(",
            message: "Beat with name:\n\n\(beatName)\n\nalready exists.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.askForNewBeatNameAndSave(senderButtonTitle: senderButtonTitle)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func askForNewBeatNameAndSave(senderButtonTitle: BeatButtonLabel) {
        print(senderButtonTitle)
        let alert = UIAlertController(title: "Save beat",
                                      message: "Please enter new beat name:",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.editingNewBeat = true
        })
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let textField = alert.textFields![0] as UITextField
            if let newBeatName = textField.text {
                if ExampleBeatNotes.saveExampleBeatToRealm(beatNotes: ExamplePlayer.exampleBeatNotes,
                                                           beatName: newBeatName) {
                    self.showAlertWithMessageSaved()
                    self.editingNewBeat = false
                    self.defaults.set(newBeatName, forKey: "currentlySelectedBeatName")
                } else {
                    self.showABeatAlreadyExistsAlert(beatName: newBeatName, senderButtonTitle: senderButtonTitle)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                if senderButtonTitle == .back {
                    print("111")
                    self.dismiss(animated: true, completion: nil)
                } else if senderButtonTitle == .beats {
                    print("222")
                    self.performSegue(withIdentifier: "goToBeatsTableView", sender: self)
                }
            }
        }
        alert.addTextField(configurationHandler: { (textField) in
            textField.text = ""
            saveAction.isEnabled = false
            _ = NotificationCenter.default
                .addObserver(forName: NSNotification.Name.UITextFieldTextDidChange,
                             object: textField,
                             queue: OperationQueue.main) { _ in
                                saveAction.isEnabled = textField.text!.count > 0
            }
        })
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        self.present(alert, animated: true, completion: nil)
    }

    func createNewBeat() {
        editingNewBeat = true
        notes = ExamplePlayer.exampleBeatNotes
        collectionView.reloadData()
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.backgroundColor = UIColor.white
        changeNoteForCell(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        changeNoteForCell(indexPath: indexPath)
        selectedCell?.backgroundColor = UIColor.yellow
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SelectBeatTableViewController {
            viewController.delegate = self
        }
    }

    func askIfUserWantToSaveCurrentlyEditedBeat(callerButtonTitle: BeatButtonLabel) {
        let alert = UIAlertController(title: "Save beat",
                                      message: "Do you want to save current beat?",
                                      preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: { _ in
            if callerButtonTitle == .back {
                self.dismiss(animated: true, completion: { () -> Void in
                    let currentlySelectedBeat = self.defaults.string(forKey: "currentlySelectedBeatName")
                    ExamplePlayer.exampleBeatNotes = BeatNotesLoader.getNotesFor(
                        exampleBeatName: currentlySelectedBeat ?? "Simple House",
                        beatIndex: 0)
                })
            } else if callerButtonTitle == .beats {
                self.performSegue(withIdentifier: "goToBeatsTableView", sender: self)
            }
            let currentlySelectedBeat = self.defaults.string(forKey: "currentlySelectedBeatName")
            ExamplePlayer.exampleBeatNotes = BeatNotesLoader.getNotesFor(
                exampleBeatName: currentlySelectedBeat ?? "Simple House",
                beatIndex: 0)
        })
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            if callerButtonTitle == .back {
                self.askForNewBeatNameAndSave(senderButtonTitle: .back)
            } else if callerButtonTitle == .beats {
                self.askForNewBeatNameAndSave(senderButtonTitle: .beats)
            }
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true, completion: nil)
        self.editingNewBeat = false
    }

}

extension BeatEditViewController: CollectionViewDelegateHorizontalGridLayout {

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               rowSpacingForSection section: Int) -> CGFloat {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               columnSpacingForSection section: Int) -> CGFloat {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSection section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               widthForItemAt indexPath: IndexPath,
                               rowHeight columnHeight: CGFloat) -> CGFloat {
        return 50
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               widthForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               numberOfRowsForSection section: Int) -> Int {
        return self.numberOfRows
    }

}

extension BeatEditViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 128
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PathCollectionViewCell.identifier,
                                 for: indexPath) as? PathCollectionViewCell else {
            fatalError("Cannot retrieve PathCollectionViewCell")
        }
        if cell.isSelected {
            cell.backgroundColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.yellow
        }
        cell.setIndexPath(indexPath)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind,
                                              withReuseIdentifier: CollectionReusableView.identifier,
                                              for: indexPath) as? CollectionReusableView else {
            fatalError("Cannot retrieve CollectionReusableView")
        }
        view.setIndexPath(indexPath, kind: kind)
        return view
    }

}

protocol NoteChangerDelegate: AnyObject {
    func changeNote(drumPadIndex: Int, noteIndex: Int)
}

enum BeatButtonLabel {
    case back
    case beats
    case save
}
