//
//  QuoteTableViewCell.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    public static let identifier = "QUOTE_TABLEVIEW_CELL_ID"
    var data: Quote?{
        didSet{
            self.quoteLabel.text = self.data!.quote
            self.authorLabel.text = "--- " + self.data!.author
            self.setupView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(){
        self.quoteLabel.x = 10
        self.quoteLabel.y = 10
        self.quoteLabel.width = screenWidth - 60
        self.quoteLabel.height = Util.heightForView(text: self.data!.quote, font: UIFont.systemFont(ofSize: 17), width: self.quoteLabel.width)
        
        self.authorLabel.x = 5
        self.authorLabel.y = self.quoteLabel.bottom + 18
        self.authorLabel.width = screenWidth - 60
        self.authorLabel.height = 22
    }
}
