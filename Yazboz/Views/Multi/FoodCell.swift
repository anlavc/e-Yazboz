//
//  FoodCell.swift
//  Yazboz
//
//  Created by Anıl AVCI on 22.05.2023.
//

import UIKit

class FoodCell: UITableViewCell {
    static let identifier = "FoodCell"

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var foodCount: UILabel!
    @IBOutlet weak var foofName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    static func nib() -> UINib {
        return UINib(nibName: "FoodCell", bundle: nil)
    }
}
