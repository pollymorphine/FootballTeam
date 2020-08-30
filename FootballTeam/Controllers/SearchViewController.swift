//
//  SearchViewController.swift
//  FootballTeam
//
//  Created by Polina on 22.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit
import Foundation
import CoreData

protocol SearchDelegate: class {
    func viewController(_ viewController: SearchViewController,
                        didPassedData predicate: NSCompoundPredicate)
}

class SearchViewController: UIViewController {
    
    weak var delegate: SearchDelegate?
    
// MARK: - IBOutlet
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var segmentedControlView: UISegmentedControl!
    @IBOutlet weak var selectPositionButton: UIButton!
    @IBOutlet weak var selectTeamButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var selectLabel: UILabel!
    
// MARK: - Private properties
    
    private var isSelectTeam = true
    private var selectedTeam: String = ""
    private var selectedPosition: String = ""
    
// MARK: - Life cyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
// MARK: - Methods
    
    @IBAction func selectTeamButtonPressed(_ sender: Any) {
        isSelectTeam = true
        selectLabel.text = Text.selectTeam
        pickerView.reloadAllComponents()
        pickerContainerView.isHidden = false
    }
    
    @IBAction func selectPositionButtonPressed(_ sender: Any) {
        isSelectTeam = false
        selectLabel.text = Text.selectPosition
        pickerView.reloadAllComponents()
        pickerContainerView.isHidden = false
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text, let age = ageTextField.text else { return }
        let compoundPredicate = makeCompoundPredicate(name: name,
                                                      age: age,
                                                      team: selectedTeam,
                                                      position: selectedPosition)
        delegate?.viewController(self, didPassedData: compoundPredicate)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        delegate?.viewController(self, didPassedData: NSCompoundPredicate(andPredicateWithSubpredicates: []))
        dismiss(animated: true, completion: nil)
    }
    
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         dismiss(animated: true, completion: nil)
    }

    private func setupUI() {
        pickerContainerView.isHidden = true
        searchButton.layer.cornerRadius = 5.0
        resetButton.layer.cornerRadius = 5.0
    }
}

// MARK: - Predicate

extension SearchViewController {
    private func makeCompoundPredicate(name: String,
                                       age: String,
                                       team: String,
                                       position: String) -> NSCompoundPredicate {
        
        var predicates = [NSPredicate]()
        
        if !name.isEmpty {
            let namePredicate = NSPredicate(format: "\(Predicate.playerName) '\(name)'")
            predicates.append(namePredicate)
        }
        
        if !position.isEmpty {
            let positionPredicate = NSPredicate(format: "\(Predicate.position) '\(position)'")
            predicates.append(positionPredicate)
        }
        
        if !team.isEmpty {
            let teamPredicate = NSPredicate(format: "\(Predicate.teamName) '\(team)'")
            predicates.append(teamPredicate)
        }
        
        if !age.isEmpty {
            let selectedSegmentControl = ageCondition(index: segmentedControlView.selectedSegmentIndex)
            let agePredicate = NSPredicate(format: "\(Predicate.age) \(selectedSegmentControl) '\(age)'")
            predicates.append(agePredicate)
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
    
    private func ageCondition(index: Int) -> String {
        var condition: String!
        
        switch index {
        case 0: condition = ">="
        case 1: condition = "="
        case 2: condition = "<="
        default: break
        }
        
        return condition
    }
}

// MARK: - PickerView

extension SearchViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isSelectTeam {
            selectTeamButton.setTitle(Array.teams[row], for: .normal)
            selectedTeam = Array.teams[row]
        } else {
            selectPositionButton.setTitle(Array.position[row], for: .normal)
            selectedPosition = Array.position[row]
        }
        pickerContainerView.isHidden = true
    }
}

extension SearchViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return isSelectTeam ? Array.teams.count : Array.position.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return isSelectTeam ? Array.teams[row] : Array.position[row]
    }
}
