//
//  PlayerViewController.swift
//  FootballTeam
//
//  Created by Polina on 10.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var playerNumber: UITextField!
    @IBOutlet weak var playerPhoto: UIImageView!
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerNationality: UITextField!
    @IBOutlet weak var playerAge: UITextField!
    @IBOutlet weak var selectTeamButton: UIButton!
    @IBOutlet weak var selectPositionButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Private properties
    
    private var imagePickerController = UIImagePickerController()
    private var selectedTeam: String!
    private var selectedPosition: String!
    private var isSelectTeam = true
    var dataManager: CoreDataManager!
    var player: Player!
    
    // MARK: - Life cyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setKeyboardNotification()
        setupDelegate() 
    }
    
    // MARK: - Methods
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func selectTeamButtonPressed(_ sender: Any) {
        isSelectTeam = true
        addPickerView(title: Text.chooseTeam)
    }
    
    @IBAction func selectPositionButtonPressed(_ sender: Any) {
        isSelectTeam = false
        addPickerView(title: Text.choosePosition)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let context = dataManager.getContext()
        
        let team = dataManager.createObject(from: Club.self)
        team.name = selectedTeam
        
        let player = dataManager.createObject(from: Player.self)
        guard let age = playerAge.text else { return }
        guard let num = playerAge.text else { return }
        player.fullName = playerName.text
        player.nationality = playerNationality.text
        player.age = Int16(age) ?? 0
        player.number = Int16(num) ?? 0
        player.position = selectedPosition
        player.club = team
        player.image = playerPhoto.image
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            player.inPlay = true
        case 1:
            player.inPlay = false
        default: ()
        }
        
        dataManager.save(context: context)
        navigationController?.popViewController(animated: true)
    }
    
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        disableSaveItemButton()
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        saveButton.layer.cornerRadius = 6
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = .blue
        navigationItem.title = Text.titlePlayerVC
    }
    
    private func setupDelegate() {
        imagePickerController.delegate = self
        playerNumber.delegate = self
        playerAge.delegate = self
        playerName.delegate = self
        playerNationality.delegate = self
    }
    
    private func disableSaveItemButton() {
        saveButton.isEnabled = false
        saveButton.alpha = 0.5
    }
    
    private func enableSaveItemButton() {
        guard
            let name = playerName.text,
            let nationality = playerNationality.text,
            let age = playerAge.text,
            let number = playerNumber.text
            else { return }
        
        if !name.isEmpty && !nationality.isEmpty && !age.isEmpty && !number.isEmpty  {
            saveButton.isEnabled = true
            saveButton.alpha = 1
        }
    }
    
    private func addPickerView(title: String) {
        let alertView = UIAlertController( title: title, message: Text.message, preferredStyle: .alert)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 50, width: 260, height: 120))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.reloadAllComponents()
        alertView.view.addSubview(pickerView)
        alertView.addAction(UIAlertAction(title: Text.cancel, style: .destructive, handler: nil))
        alertView.addAction(UIAlertAction(title: Text.done, style: .default, handler: nil))
        present(alertView, animated: true)
    }
}

// MARK: - PickerView

extension PlayerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isSelectTeam {
            selectTeamButton.setTitle(Array.teams[row], for: .normal)
            selectedTeam = Array.teams[row]
        } else {
            selectPositionButton.setTitle(Array.position[row], for: .normal)
            selectedPosition = Array.position[row]
        }
        enableSaveItemButton()
    }
}

extension PlayerViewController: UIPickerViewDataSource {
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

// MARK: - ImagePickerController

extension PlayerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage]  as? UIImage {
            playerPhoto.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}



