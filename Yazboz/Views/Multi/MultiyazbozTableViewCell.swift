//
//  MultiyazbozTableViewCell.swift
//  Yazboz
//
//  Created by Anıl AVCI on 21.05.2023.
//

import UIKit

class MultiyazbozTableViewCell: UITableViewCell {
    @IBOutlet weak var team2Point: UILabel!
    @IBOutlet weak var team1Point: UILabel!
    @IBOutlet weak var lineNumber: UILabel!
    @IBOutlet weak var bgStack: UIStackView!
    static let identifier = "MultiyazbozTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "MultiyazbozTableViewCell", bundle: nil)
    }
}
