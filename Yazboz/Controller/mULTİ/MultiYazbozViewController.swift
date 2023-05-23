//
//  MultiYazbozViewController.swift
//  Yazboz
//
//  Created by Anıl AVCI on 18.05.2023.
//

import UIKit

class MultiYazbozViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var yazbozView: UIView!
    @IBOutlet weak var panoView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
  
    @IBOutlet weak var avatarTableTeam1: UIImageView!
    @IBOutlet weak var avatarTableTeam2: UIImageView!
    @IBOutlet weak var avatarPanoTeam2: UIImageView!
    @IBOutlet weak var avatarPanoTeam1: UIImageView!
    
    @IBOutlet weak var team2PointTextField: UITextField!
    @IBOutlet weak var team1PointTextField: UITextField!
    
    @IBOutlet weak var team2NameLabel: UILabel!
    @IBOutlet weak var team1NameLabel: UILabel!
    
    @IBOutlet weak var team1playerName: UILabel!
    @IBOutlet weak var team2playerName: UILabel!
    
    @IBOutlet weak var team1TotalPoint: UILabel!
    @IBOutlet weak var team2TotalPoint: UILabel!

    
    @IBOutlet weak var team1PunishmentPoint: UILabel!
    @IBOutlet weak var team2PunishmentPoint: UILabel!

    
    @IBOutlet weak var team1Stepper: UIStepper!
    @IBOutlet weak var team2Stepper: UIStepper!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var team1Name: String?
    var team2Name: String?
    var teamavatar1: UIImage?
    var teamavatar2: UIImage?
    
 
    var gameName: String?
    let cell            = "cell"
    var maxGameNumber = 11
    var team1total : Int?  = 0
    var team2total : Int? = 0
    var isCalculationVisible = false
    var totalValue: Double = 0
    var messageView: UIView?
    var previousValue: Double = 0
    var punishmentpoint1 : Int?  = 0
    var punishmentpoint2 : Int? = 0
    var teampoint1 : Int?  = 0
    var teampoint2 : Int? = 0
    var currentValues: [Double] = [0, 0]
    var leftBarButton: UIBarButtonItem?
    var rightBarButton: UIBarButtonItem!
    
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
    func stepperAlert(sender: UIStepper, playerIndex: Int, teamName: String) {
        let currentValue = sender.value
        
        if currentValue > currentValues[playerIndex] {
            viewalert(message: "\(teamName) 101 Ceza Puanı Eklendi.", color: UIColor.systemRed)
        } else if currentValue < currentValues[playerIndex] {
            viewalert(message: "\(teamName) -101 Düşer Eklendi.", color: UIColor.systemGreen)
        }
        currentValues[playerIndex] = currentValue
    }
    //MARK: - Xib Register
    private func xibRegister() {
        tableView.register(MultiyazbozTableViewCell.nib(), forCellReuseIdentifier: MultiyazbozTableViewCell.identifier)
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
    
        team1NameLabel.text = team1Name
        team2NameLabel.text = team2Name
  
        yazbozView.isHidden   = true
        team1playerName.text = team1Name
        team2playerName.text = team2Name
     
        
        game[0].players[0].playerName = team1Name
        game[0].players[1].playerName = team2Name

        game[0].name = gameName
        
        team1TotalPoint.text = "Toplam: ?"
        team2TotalPoint.text = "Toplam: ?"

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
             game[0].rounts[1].points.removeAll()] as? [Any];
            [self.tableView .reloadData()]
            self.punishmentpoint1 = 0
            self.punishmentpoint2 = 0
         
            self.navigationController?.popViewController(animated: true)
        } cancelAction: {
            self.dismiss(animated: true)
        }
    }
    @objc func finishGame() {
        showAlert(title: title ?? "Okey 101", message: "Oyun bitirmek istediğinizden emin misiniz?", okButtonTitle: "Bitir", cancelButtonTitle: "İptal") {
            let vc = MultiLeaderBoardVC()
            vc.punishment1 = self.punishmentpoint1
            vc.punishment2 = self.punishmentpoint2
    
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
        team1PointTextField.inputAccessoryView = toolBar
        team2PointTextField.inputAccessoryView = toolBar
      
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
        team1total = 0
        for oyuncu in game[0].rounts[0].points {
            team1total = team1total! + oyuncu
            game[0].total[0].PlayerTotal = team1total
            team1total = game[0].total[0].PlayerTotal!
        }
        team2total = 0
        for oyuncu in game[0].rounts[1].points {
            
            team2total = team2total! + oyuncu
            game[0].total[1].PlayerTotal = team2total
            team2total = game[0].total[1].PlayerTotal!
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
                self.navigationController?.pushViewController(vc, animated: true)
            } cancelAction: {
                self.dismiss(animated: true)
            }
        } else {
            let say1 = Int(team1PointTextField.text!) ?? 0
            let say2 = Int(team2PointTextField.text!) ?? 0
            game[0].rounts[0].points.append(contentsOf: [say1])
            game[0].rounts[1].points.append(contentsOf: [say2])
            
            team1PointTextField.text = ""
            team2PointTextField.text = ""
           
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
        stepperAlert(sender: sender, playerIndex: 0,teamName: team1Name!)
        let value = Int(sender.value)
        punishmentpoint1 = value
        
        if isCalculationVisible {
            updateTotalPoints()
        }
        
        if value > 0 {
            team1PunishmentPoint.text = "C.P: \(value)"
            team1PunishmentPoint.textColor = .red
        } else if value < 0 {
            team1PunishmentPoint.text = "C.P: \(value)"
            team1PunishmentPoint.textColor = .systemGreen
        } else {
            team1PunishmentPoint.text = "C.P: 0"
            team1PunishmentPoint.textColor = .black
        }
    }
    @IBAction func player2Stepper(_ sender: UIStepper) {
        stepperAlert(sender: sender, playerIndex: 1,teamName: team2Name!)
        let value = Int(sender.value)
        punishmentpoint2 = value
        if isCalculationVisible {
            updateTotalPoints()
        }
        if value > 0 {
            team2PunishmentPoint.text = "C.P: \(value)"
            team2PunishmentPoint.textColor = .red
        } else if value < 0 {
            team2PunishmentPoint.text = "C.P: \(value)"
            team2PunishmentPoint.textColor = .systemGreen
        } else {
            team2PunishmentPoint.text = "C.P: 0"
            team2PunishmentPoint.textColor = .black
        }
    }
    //MARK: - TotalPoint Hide
    func hideTotalPoints() {
        team1TotalPoint.text = "Toplam ?"
        team2TotalPoint.text = "Toplam ?"
      
    }
    //MARK: - Total Point Show
    func showTotalPoints() {
        updateTotalPoints()
    }
    //MARK: - Total Point Calculate
    func updateTotalPoints() {
        if let player1Total = team1total, let punishment1 = punishmentpoint1 {
            team1TotalPoint.text = "Toplam: \(player1Total + punishment1)"
        } else {
            print("Hata: player1total veya punishmentpoint1 nil!")
        }
        
        if let player2Total = team2total, let punishment2 = punishmentpoint2 {
            team2TotalPoint.text = "Toplam: \(player2Total + punishment2)"
        } else {
            print("Hata: player2total veya punishmentpoint2 nil!")
        }
    }

}
//MARK: - TableView Delegate & DataSource
extension MultiYazbozViewController: UITableViewDelegate,UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if game[0].rounts[0].points.count == 0 {
    tableView.setEmptyView(title: "YAZBOZ Okey 101", message: "Oyun toplam 11 el oynanacak ve iyi olan kazansın.")
    }
    else {
    tableView.restore()
    }

    
    return game[0].rounts[0].points.count}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MultiyazbozTableViewCell.identifier, for: indexPath) as!  MultiyazbozTableViewCell
    cell.lineNumber.text = String("\(indexPath.row + 1).")
    cell.team1Point.text = String(game[0].rounts[0].points[indexPath.row])
    cell.team2Point.text = String(game[0].rounts[1].points[indexPath.row])

    
    if indexPath.row % 2 == 0 {
        cell.bgStack.backgroundColor = .systemGray6
    } else {
        cell.bgStack.backgroundColor = UIColor(named: "bgcolor")
    }
    return cell
}
func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let silAction = UIContextualAction(style: .destructive, title: "Sil") {  (contextualAction, view, boolValue) in
        game[0].rounts[0].points.remove(at: indexPath.row)
        game[0].rounts[1].points.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.totalcal()
        self.updateTotalPoints()
        tableView.reloadData()
    }
    return UISwipeActionsConfiguration(actions: [silAction])
}

}
