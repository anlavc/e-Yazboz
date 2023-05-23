//
//  yazbozTableViewCell.swift
//  Yazboz
//
//  Created by Anıl AVCI on 18.05.2023.
//

import UIKit

class yazbozTableViewCell: UITableViewCell {
    static let identifier = "yazbozTableViewCell"
    
    @IBOutlet weak var bgstack: UIStackView!
    @IBOutlet weak var player4Point: UILabel!
    @IBOutlet weak var player3Point: UILabel!
    @IBOutlet weak var player2Point: UILabel!
    @IBOutlet weak var player1Point: UILabel!
    @IBOutlet weak var lineNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgstack.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "yazbozTableViewCell", bundle: nil)
    }
}
