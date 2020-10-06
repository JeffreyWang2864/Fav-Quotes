//
//  NewQuoteViewController.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import UIKit

class NewQuoteViewController: UIViewController {
    @IBOutlet var quoteTextView: UITextView!
    @IBOutlet var authorTextView: UITextView!
    var callback: (() -> Void)?
    var data: Quote?{
        didSet{
            self.quoteTextView.text = self.data!.quote.isEmpty ? "New quote..." : self.data!.quote
            self.adjustQuoteLabelHeight()
            
            self.authorTextView.text = self.data!.author.isEmpty ? "Written by..." : self.data!.author
            if(self.authorTextView.text == "Written by..."){
                self.authorTextView.textColor = .lightGray
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.callback?()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupView(){
        self.view.backgroundColor = FQColor.themeColor
        
        self.quoteTextView.delegate = self
        self.quoteTextView.textContainer.lineBreakMode = .byTruncatingTail
        self.quoteTextView.textContainer.maximumNumberOfLines = 0
        self.quoteTextView.layer.backgroundColor = FQColor.themeColor.cgColor
        self.quoteTextView.textColor = .white
        
        self.authorTextView.delegate = self
        self.authorTextView.textContainer.lineBreakMode = .byTruncatingTail
        self.authorTextView.textContainer.maximumNumberOfLines = 0
        self.authorTextView.layer.backgroundColor = UIColor.white.cgColor
    }
    
    func adjustQuoteLabelHeight(){
        //adjust quote label height
        let lineHeight = Util.heightForView(text: self.quoteTextView.text, font: self.quoteTextView.font!, width: self.quoteTextView.width)
        let c = self.quoteTextView.constraints[0]
        c.constant = lineHeight + 70
    }
}

extension NewQuoteViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if(textView === self.quoteTextView){
            self.adjustQuoteLabelHeight()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView === self.quoteTextView){
            if(textView.text == "New quote..."){
                textView.text = ""
                return
            }
        }
        if(textView.text == "Written by..."){
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView === self.quoteTextView){
            self.data!.quote = textView.text
            if(textView.text.isEmpty){
                textView.text = "New quote..."
            }
            return
        }
        self.data!.author = textView.text
        if(textView.text.isEmpty){
            textView.text = "Written by..."
            textView.textColor = UIColor.lightGray
        }
    }
}
