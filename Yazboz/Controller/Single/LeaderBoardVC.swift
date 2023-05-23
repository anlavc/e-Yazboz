//
//  LeaderBoardVC.swift
//  Yazboz
//
//  Created by Anıl AVCI on 19.05.2023.
//

import UIKit

class LeaderBoardVC: UIViewController {

    @IBOutlet weak var avatar4: UIImageView!
    @IBOutlet weak var avatar3: UIImageView!
    @IBOutlet weak var avatar2: UIImageView!
    @IBOutlet weak var avatar1: UIImageView!
    
    @IBOutlet weak var player4NameLabel: UILabel!
    @IBOutlet weak var player3NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player1NameLabel: UILabel!
    
    @IBOutlet weak var player1TotalPoint: UILabel!
    @IBOutlet weak var player2TotalPoint: UILabel!
    @IBOutlet weak var player3TotalPoint: UILabel!
    @IBOutlet weak var player4TotalPoint: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    
    var punishment1 : Int?
    var punishment2 : Int?
    var punishment3 : Int?
    var punishment4 : Int?
    
    var LeaderName1 = game[0].players[0].playerName
    var LeaderName2 = game[0].players[1].playerName
    var LeaderName3 = game[0].players[2].playerName
    var LeaderName4 = game[0].players[3].playerName
    var totalScore1 = game[0].total[0].PlayerTotal
    var totalScore2 = game[0].total[1].PlayerTotal
    var totalScore3 = game[0].total[2].PlayerTotal
    var totalScore4 = game[0].total[3].PlayerTotal
    
 

    //MARK: -  LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        calculate()
        leftbutton()
        rightbutton()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: false)
    }
    //MARK: - UI Config
    func setupUI() {
        bgView.layer.cornerRadius = 15
        view1.layer.cornerRadius  = 10
        view2.layer.cornerRadius  = 10
        view3.layer.cornerRadius  = 10
        view4.layer.cornerRadius  = 10
    }
    //MARK: - LeftBarButton
    private func leftbutton() {
        let leftBarButton = UIBarButtonItem(title: "Yeni Oyun", style: .plain, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    @objc func leftButtonTapped() {
        showAlert(title: "Dikkat", message: "Yeni oyuna başla.", okButtonTitle: "TAMAM", cancelButtonTitle: "İPTAL") {
            [game[0].rounts[0].points.removeAll(),
             game[0].rounts[1].points.removeAll(),
             game[0].rounts[2].points.removeAll(),
             game[0].rounts[3].points.removeAll()] as? [Any];
            self.navigationController?.popToRootViewController(animated: true)
        } cancelAction: {
            self.dismiss(animated: true)
        }
           }
    //MARK: - RightBarButton
    private func rightbutton() {
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    @objc func rightButtonTapped(_ sender: UIButton) {

        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [image as Any], applicationActivities: nil)
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            activityViewController.popoverPresentationController?.sourceView = sender
            
            activityViewController.completionWithItemsHandler = { [weak self] activityType, completed, returnedItems, error in
            }
            
            viewController.present(activityViewController, animated: true, completion: nil)
        }
           }
    
    private func calculate() {
        var totalScores = [totalScore1, totalScore2, totalScore3, totalScore4]
        var punishments = [punishment1, punishment2, punishment3, punishment4]

        for i in 0..<totalScores.count {
            if let score = totalScores[i] {
                if let currentPunishment = punishments[i] {
                    punishments[i] = currentPunishment + score
                } else {
                    punishments[i] = score
                }
                totalScores[i] = punishments[i]
            }
        }

        let sortedScores = totalScores.sorted { $0 ?? 0 > $1 ?? 0 }

        let playerLabels = [player4NameLabel, player3NameLabel, player2NameLabel, player1NameLabel]
        let avatarImages = [avatar4, avatar3, avatar2, avatar1]
        let avatars = ["avatar_1", "avatar_2", "avatar_3", "avatar_4"]

        for i in 0..<sortedScores.count {
            playerLabels[i]!.text = "Oyuncu Adı"
            avatarImages[i]!.image = nil

            var equalScores: [String] = [] // Eşit puanı alan oyuncuları tutmak için dizi oluşturuldu

               for j in 0..<totalScores.count {
                   if sortedScores[i] == totalScores[j] {
                       equalScores.append(String(game[0].players[j].playerName ?? "Oyuncu Adı")) // Eşit puanı alan oyuncuyu diziye ekle
                       avatarImages[i]!.image = UIImage(named: avatars[j])
                   }
               }

               // Eşit puanı alan oyuncuları virgülle ayrılmış şekilde yazdır
               playerLabels[i]!.text = equalScores.joined(separator: ", ")
        }

        player4TotalPoint.text = "\(sortedScores[0] ?? 0)"
        player3TotalPoint.text = "\(sortedScores[1] ?? 0)"
        player2TotalPoint.text = "\(sortedScores[2] ?? 0)"
        player1TotalPoint.text = "\(sortedScores[3] ?? 0)"
    }


}
