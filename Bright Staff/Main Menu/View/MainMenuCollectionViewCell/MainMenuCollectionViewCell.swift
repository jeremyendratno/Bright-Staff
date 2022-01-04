//
//  MainMenuCollectionViewCell.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/3/22.
//

import UIKit

class MainMenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderingView()
    }
    
    func borderingView() {
        borderView.layer.cornerRadius = 10
        borderView.layer.borderColor = UIColor.gray.cgColor
        borderView.layer.borderWidth = 1
    }

}
