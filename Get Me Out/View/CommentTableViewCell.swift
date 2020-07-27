//
//  CommentTableViewCell.swift
//  Get Me Out
//
//  Created by Salah  on 14/03/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bubbleMessage: UIView!
    @IBOutlet weak var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bubbleMessage.layer.cornerRadius=bubbleMessage.frame.height/5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    var comments:Rate?{
        didSet{
           setData()
        }
    }
    
    
    func setData(){
        label.text = comments?.comment
        let url = URL(string: (self.comments?.user.imageurl)!)
        myImage.kf.setImage(with: url)

    }
}
