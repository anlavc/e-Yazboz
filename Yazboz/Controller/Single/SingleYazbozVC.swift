//
//  SingleYazbozVC.swift
//  Yazboz
//
//  Created by Anıl AVCI on 18.05.2023.
//

import UIKit

class SingleYazbozVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var yazbozView: UIView!
    @IBOutlet weak var panoView: UIView!
    @IBOutlet weak var avatar4: UIImageView!
    @IBOutlet weak var avatar3: UIImageView!
    @IBOutlet weak var avatar2: UIImageView!
    @IBOutlet weak var avatar1: UIImageView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var player4PointTextField: UITextField!
    @IBOutlet weak var player3PointTextField: UITextField!
    @IBOutlet weak var player2PointTextField: UITextField!
    @IBOutlet weak var player1PointTextField: UITextField!
    
    @IBOutlet weak var player4NameLabel: UILabel!
    @IBOutlet weak var player3NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player1NameLabel: UILabel!
    
    @IBOutlet weak var table1playerName: UILabel!
    @IBOutlet weak var table2playerName: UILabel!
    @IBOutlet weak var table3playerName: UILabel!
    @IBOutlet weak var table4playerName: UILabel!
    
    @IBOutlet weak var player1TotalPoint: UILabel!
    @IBOutlet weak var player2TotalPoint: UILabel!
    @IBOutlet weak var player3TotalPoint: UILabel!
    @IBOutlet weak var player4TotalPoint: UILabel!
    
    @IBOutlet weak var player1PunishmentPoint: UILabel!
    @IBOutlet weak var player2PunishmentPoint: UILabel!
    @IBOutlet weak var player3PunishmentPoint: UILabel!
    @IBOutlet weak var player4PunishmentPoint: UILabel!
    
    @IBOutlet weak var player1Stepper: UIStepper!
    @IBOutlet weak var player2Stepper: UIStepper!
    @IBOutlet weak var player3Stepper: UIStepper!
    @IBOutlet weak var player4Stepper: UIStepper!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var player1Name: String?
    var player2Name: String?
    var player3Name: String?
    var player4Name: String?
    var gameName: String?
    let cell            = "cell"
    var maxGameNumber = 11
    var player1total : Int?  = 0
    var player2total : Int? = 0
    var player3total : Int? = 0
    var player4total : Int? = 0
    var isCalculationVisible = false
    var totalValue: Double = 0
    var messageView: UIView?
    var previousValue: Double = 0
    var punishmentpoint1 : Int?  = 0
    var punishmentpoint2 : Int? = 0
    var punishmentpoint3 : Int? = 0
    var punishmentpoint4 : Int? = 0
    var currentValues: [Double] = [0, 0, 0, 0]
    var leftBarButton: UIBarButtonItem?
    var rightBarButton: UIBarButtonItem!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboard()
        setupUI()
        tableviewSetup()
        xibRegister()
        barbutton()
        keyboardDone()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    //MARK: - StepperPress Bottom Info View
    func viewalert(message: String, color: UIColor) {
        let messageView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width, height: 40))
        messageView.backgroundColor = color
        let messageLabel = UILabel(frame: messageView.bounds)
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageView.addSubview(messageLabel)
        self.view.addSubview(messageView)
        // Animation dismiss
        UIView.animate(withDuration: 1.5, delay: 1.0, options: [], animations: {
            messageView.alpha = 0
        }, completion: { _ in
            messageView.removeFromSuperview()
        })
    }
    //MARK: - StepperPress Bottom Info Text and Color
    func stepperAlert(sender: UIStepper, playerIndex: Int, playerName: String) {
        let currentValue = sender.value
        
        if currentValue > currentValues[playerIndex] {
            viewalert(message: "\(playerName) 101 Ceza Puanı Eklendi.", color: UIColor.systemRed)
        } else if currentValue < currentValues[playerIndex] {
            viewalert(message: "\(playerName) -101 Düşer Eklendi.", color: UIColor.systemGreen)
        }
        currentValues[playerIndex] = currentValue
    }
    //MARK: - Xib Register
    private func xibRegister() {
        tableView.register(yazbozTableViewCell.nib(), forCellReuseIdentifier: yazbozTableViewCell.identifier)
    }
    //MARK: - Tableview Setup
    private func tableviewSetup() {
        tableView.dataSource = self
        tableView.delegate   = self
    }
    //MARK: - SetupUI
    private func setupUI() {
        title = gameName
        addButton.layer.cornerRadius = 5
        
        player1NameLabel.text = player1Name
        player2NameLabel.text = player2Name
        player3NameLabel.text = player3Name
        player4NameLabel.text = player4Name
        yazbozView.isHidden   = true
        table1playerName.text = player1Name
        table2playerName.text = player2Name
        table3playerName.text = player3Name
        table4playerName.text = player4Name
        
        game[0].players[0].playerName = player1Name
        game[0].players[1].playerName = player2Name
        game[0].players[2].playerName = player3Name
        game[0].players[3].playerName = player4Name
        game[0].name = gameName
        
        player1TotalPoint.text = "Toplam: ?"
        player2TotalPoint.text = "Toplam: ?"
        player3TotalPoint.text = "Toplam: ?"
        player4TotalPoint.text = "Toplam: ?"
    }
    //MARK: - RightBarButton
    private func barbutton() {
        if segmentedControl.selectedSegmentIndex == 0 {
            rightBarButton = UIBarButtonItem(title: "Yeni Oyun", style: .plain, target: self, action: #selector(newGameButtonTapped))
            navigationItem.rightBarButtonItem = rightBarButton
            navigationItem.leftBarButtonItem = nil
        } else if segmentedControl.selectedSegmentIndex == 1 {
            
            leftBarButton = UIBarButtonItem(title: "Hesapla", style: .plain, target: self, action: #selector(calculateTotalPoint))
            navigationItem.leftBarButtonItem = leftBarButton
            
            rightBarButton = UIBarButtonItem(title: "Oyunu Bitir", style: .plain, target: self, action: #selector(finishGame))
            navigationItem.rightBarButtonItem = rightBarButton
        }
    }
    @objc func newGameButtonTapped() {
        showAlert(title: "Dikkat", message: "Tüm bilgiler silinerek yeni oyun başlatılacaktır.", okButtonTitle: "TAMAM", cancelButtonTitle: "İPTAL") {
            [game[0].rounts[0].points.removeAll(),
             game[0].rounts[1].points.removeAll(),
             game[0].rounts[2].points.removeAll(),
             game[0].rounts[3].points.removeAll()] as? [Any];
            [self.tableView .reloadData()]
            self.punishmentpoint1 = 0
            self.punishmentpoint2 = 0
            self.punishmentpoint3 = 0
            self.punishmentpoint4 = 0
            self.navigationController?.popViewController(animated: true)
        } cancelAction: {
            self.dismiss(animated: true)
        }
    }
    @objc func finishGame() {
        showAlert(title: title ?? "Okey 101", message: "Oyun bitirmek istediğinizden emin misiniz?", okButtonTitle: "Bitir", cancelButtonTitle: "İptal") {
            let vc = LeaderBoardVC()
            vc.punishment1 = self.punishmentpoint1
            vc.punishment2 = self.punishmentpoint2
            vc.punishment3 = self.punishmentpoint3
            vc.punishment4 = self.punishmentpoint4
            self.navigationController?.pushViewController(vc, animated: true)
        } cancelAction: {
            self.dismiss(animated: true)
        }
    }
    @objc func calculateTotalPoint() {
        if isCalculationVisible {
            hideTotalPoints()
            leftBarButton?.title = "Hesapla"
        } else {
            showTotalPoints()
            leftBarButton?.title = "Gizle"
        }
        isCalculationVisible = !isCalculationVisible
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
    private func keyboardDone() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: #selector(self.keyboardRemove))
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"),style: .done, target: nil, action: #selector(self.keyboardRemove))
        doneButton.tintColor = UIColor.black
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        player1PointTextField.inputAccessoryView = toolBar
        player2PointTextField.inputAccessoryView = toolBar
        player3PointTextField.inputAccessoryView = toolBar
        player4PointTextField.inputAccessoryView = toolBar
    }
    @objc func keyboardRemove() {
        view.endEditing(true)
    }
    func keyboardHidding() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardRemove))
        self.view.addGestureRecognizer(tap)
    }
    
    //MARK: - Total Point Calc.
    func totalcal() {
        player1total = 0
        for oyuncu in game[0].rounts[0].points {
            player1total = player1total! + oyuncu
            game[0].total[0].PlayerTotal = player1total
            player1total = game[0].total[0].PlayerTotal!
        }
        player2total = 0
        for oyuncu in game[0].rounts[1].points {
            
            player2total = player2total! + oyuncu
            game[0].total[1].PlayerTotal = player2total
            player2total = game[0].total[1].PlayerTotal!
        }
        player3total = 0
        for oyuncu in game[0].rounts[2].points {
            
            player3total = player3total! + oyuncu
            game[0].total[2].PlayerTotal = player3total
            player3total = game[0].total[2].PlayerTotal!
        }
        player4total = 0
        for oyuncu in game[0].rounts[3].points {
            
            player4total = player4total! + oyuncu
            game[0].total[3].PlayerTotal = player4total
            player4total = game[0].total[3].PlayerTotal!
        }
    }
    //MARK: - Button Action
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            panoView.isHidden = false
            yazbozView.isHidden = true
            hideKeyboard()
            barbutton()
            if isCalculationVisible {
                leftBarButton?.title = "Gizle"
            } else {
                leftBarButton?.title = "Hesapla"
            }
        case 1:
            panoView.isHidden = true
            yazbozView.isHidden = false
            hideKeyboard()
            barbutton()
            leftBarButton?.title = "Hesapla"
            if isCalculationVisible {
                leftBarButton?.title = "Gizle"
            } else {
                leftBarButton?.title = "Hesapla"
            }
        default:
            break
        }
    }
    //MARK: - AddButton Tapped
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        if game[0].rounts[0].points.count == maxGameNumber {
            showAlert(title: "Dikkat", message: "Toplam el sayısına ulaşıldı.Kazananın kim olduğunu görmek için bitir butonuna tıklayınız.", okButtonTitle: "Bitir", cancelButtonTitle: "İptal") {
                let vc = LeaderBoardVC()
                vc.punishment1 = self.punishmentpoint1
                vc.punishment2 = self.punishmentpoint2
                vc.punishment3 = self.punishmentpoint3
                vc.punishment4 = self.punishmentpoint4
                self.navigationController?.pushViewController(vc, animated: true)
            } cancelAction: {
                self.dismiss(animated: true)
            }
        } else {
            let say1 = Int(player1PointTextField.text!) ?? 0
            let say2 = Int(player2PointTextField.text!) ?? 0
            let say3 = Int(player3PointTextField.text!) ?? 0
            let say4 = Int(player4PointTextField.text!) ?? 0
            
            game[0].rounts[0].points.append(contentsOf: [say1])
            game[0].rounts[1].points.append(contentsOf: [say2])
            game[0].rounts[2].points.append(contentsOf: [say3])
            game[0].rounts[3].points.append(contentsOf: [say4])
            
            player1PointTextField.text = ""
            player2PointTextField.text = ""
            player3PointTextField.text = ""
            player4PointTextField.text = ""
            viewalert(message: "Puanlar eklendi.", color: UIColor.systemGreen)
            tableView.reloadData()
            totalcal()
            updateTotalPoints()
            hideKeyboard()
            if leftBarButton?.title != "Gizle" {
                hideTotalPoints()
                leftBarButton?.title = "Hesapla"
            }
            
        }
    }
    //MARK: - Stepper Punishment Pont
    @IBAction func player1Stepper(_ sender: UIStepper) {
        stepperAlert(sender: sender, playerIndex: 0, playerName: player1Name!)
        let value = Int(sender.value)
        punishmentpoint1 = value
        
        if isCalculationVisible {
            updateTotalPoints()
        }
        
        if value > 0 {
            player1PunishmentPoint.text = "C.P: \(value)"
            player1PunishmentPoint.textColor = .red
        } else if value < 0 {
            player1PunishmentPoint.text = "C.P: \(value)"
            player1PunishmentPoint.textColor = .systemGreen
        } else {
            player1PunishmentPoint.text = "C.P: 0"
            player1PunishmentPoint.textColor = .black
        }
    }
    @IBAction func player2Stepper(_ sender: UIStepper) {
        stepperAlert(sender: sender, playerIndex: 1, playerName: player2Name!)
        let value = Int(sender.value)
        punishmentpoint2 = value
        if isCalculationVisible {
            updateTotalPoints()
        }
        if value > 0 {
            player2PunishmentPoint.text = "C.P: \(value)"
            player2PunishmentPoint.textColor = .red
        } else if value < 0 {
            player2PunishmentPoint.text = "C.P: \(value)"
            player2PunishmentPoint.textColor = .systemGreen
        } else {
            player2PunishmentPoint.text = "C.P: 0"
            player2PunishmentPoint.textColor = .black
        }
    }
    @IBAction func player3Stepper(_ sender: UIStepper) {
        stepperAlert(sender: sender, playerIndex: 2,playerName: player3Name!)
        let value = Int(sender.value)
        punishmentpoint3 = value
        if isCalculationVisible {
            updateTotalPoints()
        }
        if value > 0 {
            player3PunishmentPoint.text = "C.P: \(value)"
            player3PunishmentPoint.textColor = .red
        } else if value < 0 {
            player3PunishmentPoint.text = "C.P: \(value)"
            player3PunishmentPoint.textColor = .systemGreen
        } else {
            player3PunishmentPoint.text = "C.P: 0"
            player3PunishmentPoint.textColor = .black
        }
    }
    @IBAction func player4Stepper(_ sender: UIStepper) {
        stepperAlert(sender: sender, playerIndex: 3,playerName: player4Name!)
        let value = Int(sender.value)
        punishmentpoint4 = value
        if isCalculationVisible {
            updateTotalPoints()
        }
        if value > 0 {
            player4PunishmentPoint.text = "C.P: \(value)"
            player4PunishmentPoint.textColor = .red
        } else if value < 0 {
            player4PunishmentPoint.text = "C.P: \(value)"
            player4PunishmentPoint.textColor = .systemGreen
        } else {
            player4PunishmentPoint.text = "C.P: 0"
            player4PunishmentPoint.textColor = .black
        }
    }
    //MARK: - TotalPoint Hide
    func hideTotalPoints() {
        player1TotalPoint.text = "Toplam ?"
        player2TotalPoint.text = "Toplam ?"
        player3TotalPoint.text = "Toplam ?"
        player4TotalPoint.text = "Toplam ?"
    }
    //MARK: - Total Point Show
    func showTotalPoints() {
        updateTotalPoints()
    }
    //MARK: - Total Point Calculate
    func updateTotalPoints() {
        if let player1Total = player1total, let punishment1 = punishmentpoint1 {
            player1TotalPoint.text = "Toplam: \(player1Total + punishment1)"
        } else {
            print("Hata: player1total veya punishmentpoint1 nil!")
        }
        
        if let player2Total = player2total, let punishment2 = punishmentpoint2 {
            player2TotalPoint.text = "Toplam: \(player2Total + punishment2)"
        } else {
            print("Hata: player2total veya punishmentpoint2 nil!")
        }
        
        if let player3Total = player3total, let punishment3 = punishmentpoint3 {
            player3TotalPoint.text = "Toplam: \(player3Total + punishment3)"
        } else {
            print("Hata: player3total veya punishmentpoint3 nil!")
        }
        
        if let player4Total = player4total, let punishment4 = punishmentpoint4 {
            player4TotalPoint.text = "Toplam: \(player4Total + punishment4)"
        } else {
            print("Hata: player4total veya punishmentpoint4 nil!")
        }
    }
}
//MARK: - TableView Delegate & DataSource
extension SingleYazbozVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if game[0].rounts[0].points.count == 0 {
            tableView.setEmptyView(title: "YAZBOZ Okey 101", message: "Oyun toplam 11 el oynanacak ve iyi olan kazansın.")
        }
        else {
            tableView.restore()
        }
        return game[0].rounts[0].points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: yazbozTableViewCell.identifier, for: indexPath) as! yazbozTableViewCell
        cell.lineNumber.text = String("\(indexPath.row + 1).")
        cell.player1Point.text = String(game[0].rounts[0].points[indexPath.row])
        cell.player2Point.text = String(game[0].rounts[1].points[indexPath.row])
        cell.player3Point.text = String(game[0].rounts[2].points[indexPath.row])
        cell.player4Point.text = String(game[0].rounts[3].points[indexPath.row])
        if indexPath.row % 2 == 0 {
            cell.bgstack.backgroundColor = .systemGray6
        } else {
            cell.bgstack.backgroundColor = UIColor(named: "bgcolor")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil") {  (contextualAction, view, boolValue) in
            game[0].rounts[0].points.remove(at: indexPath.row)
            game[0].rounts[1].points.remove(at: indexPath.row)
            game[0].rounts[2].points.remove(at: indexPath.row)
            game[0].rounts[3].points.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.totalcal()
            self.updateTotalPoints()
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
}
