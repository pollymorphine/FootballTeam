//
//  SearchViewController.swift
//  FootballTeam
//
//  Created by Polina on 22.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit

// MARK: Protocol
protocol SearchDelegate: class {
    func viewController(_ viewController: SearchViewController, didPassedData predicate: NSCompoundPredicate)
}

class SearchViewController: UIViewController {
    weak var delegate: SearchDelegate?
    
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
    
    private var isSelectTeam = true
    private var selectedTeam: String!
    private var selectedPosition: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addGesture()
    }
    @IBAction func selectTeamButtonPressed(_ sender: Any) {
         isSelectTeam = true
         selectLabel.text = "Select team"
         pickerView.reloadAllComponents()
         pickerContainerView.isHidden = false
    }
    
    @IBAction func selectPositionButtonPressed(_ sender: Any) {
        isSelectTeam = false
        selectLabel.text = "Select position"
        pickerView.reloadAllComponents()
        pickerContainerView.isHidden = false
        
    }
    
    @objc func tapBackGroundView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    private func addGesture() {
        let gestureView = UITapGestureRecognizer(target: self, action: #selector(tapBackGroundView(_:)))
        view.addGestureRecognizer(gestureView)
    }
    
    
    private func setupUI() {
        pickerContainerView.isHidden = true
        searchButton.layer.borderWidth = 1.0
        searchButton.layer.borderColor = UIColor.lightGray.cgColor
        searchButton.layer.cornerRadius = 5.0
        resetButton.layer.borderWidth = 1.0
        resetButton.layer.borderColor = UIColor.lightGray.cgColor
        resetButton.layer.cornerRadius = 5.0
        
        
    }
}

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
