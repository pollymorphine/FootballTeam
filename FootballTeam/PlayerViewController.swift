//
//  PlayerViewController.swift
//  FootballTeam
//
//  Created by Polina on 10.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var playerNumber: UITextField!
    @IBOutlet weak var playerPhoto: UIImageView!
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerNationality: UITextField!
    @IBOutlet weak var playerAge: UITextField!
    // @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectTeamButton: UIButton!
    @IBOutlet weak var selectPositionButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    private var imagePickerController = UIImagePickerController()
    private var selectedTeam: String!
    private var selectedPosition: String!
    private var selectTeam = true
    
    var picker: UIPickerView!
    
    var dataManager: CoreDataManager!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIScreen.main.bounds.size.height <= 667 {
                   setKeyboardNotification()
               }
               
               self.playerAge.delegate = self

               self.playerName.delegate = self
               self.playerNationality.delegate = self
               
                       
              
               
               let gestureView = UITapGestureRecognizer(target: self, action: #selector(tapRootView(_:)))
               view.addGestureRecognizer(gestureView)
        
        setupUI()
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func selectTeamButtonPressed(_ sender: Any) {
        selectTeam = true
        //        pickerView.isHidden = false
        //        pickerView.reloadAllComponents()
        
        addPickerView(title: "Choose team")
        //pickerView.reloadAllComponents()
        
    }
    
    @IBAction func selectPositionButtonPressed(_ sender: Any) {
        selectTeam = false
        //        pickerView.isHidden = false
        //        pickerView.reloadAllComponents()
        addPickerView(title: "Choose position")
        
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let context = dataManager.getContext()
        
        let team = dataManager.createObject(from: Club.self)
        team.name = selectedTeam
        
        let player = dataManager.createObject(from: Player.self)
        player.fullName = playerName.text
        player.nationality = playerNationality.text
        guard let plAge = playerAge.text else { return }
        player.age = Int16(plAge)!
        player.position = selectedPosition
        player.club = team
        player.number = Int16(playerAge.text!)!
        player.image = playerPhoto.image
        
        dataManager.save(context: context)
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        disableSaveItemButton()
        //pickerView.isHidden = true
        //pickerView.dataSource = self
        // pickerView.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        saveButton.layer.cornerRadius = 6
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = .blue
       // addPhotoButton.imageView?.tintColor = .white



        
        
        
    }
    
    private func disableSaveItemButton() {
        saveButton.isEnabled = false
        saveButton.alpha = 0.5
    }
    
    private func enableSaveItemButton() {
        guard
            let name = playerName.text,
            let nationality = playerNationality.text,
            let age = playerAge.text
            else { return }
        
        if !name.isEmpty && !nationality.isEmpty && !age.isEmpty {
            saveButton.isEnabled = true
            saveButton.alpha = 1
        }
    }
    
    func setKeyboardNotification() {
           NotificationCenter.default.addObserver(self,
                                                  selector: #selector(keyboardWillShow),
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
           NotificationCenter.default.addObserver(self,
                                                  selector: #selector(keyboardWillHide),
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
       }
       
       @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               if view.frame.origin.y == .zero {
                   view.frame.origin.y -= keyboardSize.height / 3
               }
           }
       }
       
       @objc func keyboardWillHide(notification: NSNotification) {
           if view.frame.origin.y != .zero {
               view.frame.origin.y = .zero
           }
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           view.endEditing(true)
           return false
       }
       
       @objc func tapRootView(_ sender: UITapGestureRecognizer) {
           view.endEditing(true)
       }


}

extension PlayerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectTeam {
            selectTeamButton.setTitle(Constants.teams[row], for: .normal)
            selectedTeam = Constants.teams[row]
        } else {
            selectPositionButton.setTitle(Constants.position[row], for: .normal)
            selectedPosition = Constants.position[row]
        }
        enableSaveItemButton()
        
    }
}

extension PlayerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

   
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectTeam {
            return Constants.teams.count
        } else {
            return Constants.position.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selectTeam {
            return Constants.teams[row]
        } else {
            return Constants.position[row]
        }
    }
}

extension PlayerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage]  as? UIImage {
        playerPhoto.image = image
        }
        dismiss(animated: true, completion: nil)

    }
    
    private func addPickerView(title: String) {
        let alertView = UIAlertController( title: title, message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 50, width: 260, height: 120))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.reloadAllComponents()
        alertView.view.addSubview(pickerView)
        alertView.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alertView.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        present(alertView, animated: true)
    }
}



