//
//  TableView + Ext.swift
//  Yazboz
//
//  Created by Anıl AVCI on 21.05.2023.
//

import UIKit


extension UITableView {
func setEmptyView(title: String, message: String) {
    let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
let titleLabel = UILabel()
let messageLabel = UILabel()
titleLabel.translatesAutoresizingMaskIntoConstraints = false
messageLabel.translatesAutoresizingMaskIntoConstraints = false
titleLabel.textColor = UIColor.black
titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
messageLabel.textColor = UIColor.lightGray
messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
emptyView.addSubview(titleLabel)
emptyView.addSubview(messageLabel)
titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
titleLabel.text = title
messageLabel.text = message
messageLabel.numberOfLines = 0
messageLabel.textAlignment = .center
// The only tricky part is here:
self.backgroundView = emptyView
self.separatorStyle = .none
}
func restore() {
self.backgroundView = nil
self.separatorStyle = .singleLine
}
}
