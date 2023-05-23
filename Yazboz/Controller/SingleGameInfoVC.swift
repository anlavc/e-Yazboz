//
//  SingleGameInfoVC.swift
//  Yazboz
//
//  Created by Anıl AVCI on 17.05.2023.
//

import UIKit

class SingleGameInfoVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var playerStack4: UIStackView!
    @IBOutlet weak var playerStack3: UIStackView!
    @IBOutlet weak var avatar4: UIImageView!
    @IBOutlet weak var avatar3: UIImageView!
    @IBOutlet weak var avatar2: UIImageView!
    @IBOutlet weak var avatar1: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var player4TextField: UITextField!
    @IBOutlet weak var player3TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var player1TextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        xibRegister()
        keyboard()
        keyboardDone()
    }
    //MARK: - Keyboard Action
    @objc func keyboard() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(gestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func hideKeyboard() {
            view.endEditing(true)
        }
    @objc func keyboardWillHide(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {

            // Klavye kaynaklı scroll ayarlamalarını sıfırlayın
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero

            // Klavye kapanma animasyonunu gerçekleştirin
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {

            let keyboardHeight = keyboardFrame.height
//            let screenHeight = UIScreen.main.bounds.height

            // Klavye yüksekliğini kullanarak scroll yapma işlemini gerçekleştirin
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)

            // Klavye açılma animasyonunu gerçekleştirin
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    //MARK: - Keyboard Done Button
    private func keyboardDone() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: #selector(self.keyboardRemove))
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"),style: .done, target: nil, action: #selector(self.keyboardRemove))
        doneButton.tintColor = UIColor.black
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        player1TextField.inputAccessoryView = toolBar
        player2TextField.inputAccessoryView = toolBar
        player3TextField.inputAccessoryView = toolBar
        player4TextField.inputAccessoryView = toolBar
        gameNameTextField.inputAccessoryView = toolBar
    }
    @objc func keyboardRemove() {
        view.endEditing(true)
    }
    func keyboardHidding() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardRemove))
        self.view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
       
    }
    private func xibRegister() {
        Bundle.main.loadNibNamed("SingleGameInfoVC", owner: self, options: nil)
    }
    private func setupUI() {
     
        title = "Yazboz"
        player1TextField.text = ""
        player2TextField.text = ""
        player3TextField.text = ""
        player4TextField.text = ""
        gameNameTextField.text = ""
        startButton.layer.cornerRadius = 5
        player1TextField.placeholder    = "Oyuncu Adı 1"
        player2TextField.placeholder    = "Oyuncu Adı 2"
        player3TextField.placeholder    = "Oyuncu Adı 3"
        player4TextField.placeholder    = "Oyuncu Adı 4"        
    }
    //MARK: - Button Actions
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if segmentedControl.selectedSegmentIndex == 0 {
            let vc = SingleYazbozVC()
            if player1TextField.text == "" {
                player1TextField.text = "Oyuncu 1"
            }
            if player2TextField.text == "" {
                player2TextField.text = "Oyuncu 2"
            }
            if player3TextField.text == "" {
                player3TextField.text = "Oyuncu 3"
            }
            if player4TextField.text == "" {
                player4TextField.text = "Oyuncu 4"
            }
            if gameNameTextField.text == "" {
                gameNameTextField.text = "Okey101"
            }
            vc.player1Name  = player1TextField.text
            vc.player2Name  = player2TextField.text
            vc.player3Name  = player3TextField.text
            vc.player4Name  = player4TextField.text
            vc.gameName     = gameNameTextField.text
            navigationController?.pushViewController(vc, animated: true)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            let vc = MultiYazbozViewController()
            if player1TextField.text == "" {
                player1TextField.text = "Takım 1"
            }
            if player2TextField.text == "" {
                player2TextField.text = "Takım 2"
            }
          
            vc.team1Name  = player1TextField.text
            vc.team2Name  = player2TextField.text
            vc.gameName     = gameNameTextField.text
            navigationController?.pushViewController(vc, animated: true)
          
        }
     
    }
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            playerStack3.isHidden           = false
            playerStack4.isHidden           = false
            player1TextField.placeholder    = "Oyuncu Adı 1"
            player2TextField.placeholder    = "Oyuncu Adı 2"
            player3TextField.placeholder    = "Oyuncu Adı 3"
            player4TextField.placeholder    = "Oyuncu Adı 4"
            avatar1.image                   = UIImage(named   : "avatar_1")
            avatar2.image                   = UIImage(named   : "avatar_2")
            avatar3.image                   = UIImage(named   : "avatar_3")
            avatar4.image                   = UIImage(named   : "avatar_4")
            player1TextField.text           = ""
            player2TextField.text           = ""
            player3TextField.text           = ""
            player4TextField.text           = ""
            gameNameTextField.text          = ""
        case 1:
            playerStack3.isHidden           = true
            playerStack4.isHidden           = true
            player1TextField.placeholder    = "Takım Adı 1"
            player2TextField.placeholder    = "Takım Adı 2"
            avatar1.image                   = UIImage(named   : "team1")
            avatar2.image                   = UIImage(named   : "team2")
            player1TextField.text           = ""
            player2TextField.text           = ""
            player3TextField.text           = ""
            player4TextField.text           = ""
            gameNameTextField.text          = ""
      
        default:
            break
        }
    }
}
