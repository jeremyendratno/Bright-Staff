//
//  AttendCollectionViewCell.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/4/22.
//

import UIKit

class AttendCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkInTimeLabel: UILabel!
    @IBOutlet weak var checkOutTimeLabel: UILabel!
    @IBOutlet weak var checkInLocationLabel: UILabel!
    @IBOutlet weak var checkOutLocationLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.black.cgColor
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowRadius = 2
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
    }
}
