//
//  BaseViewController.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/4/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var quoteCountLabel: UILabel!
    @IBOutlet var newQuoteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.tableView.register(UINib.init(nibName: "QuoteTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: QuoteTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.reloadData()
        self.newQuoteButton.addTarget(self, action: #selector(self.didSelectOnAddQuote(_:)), for: .touchDown)
    }
    
    func setupView(){
        self.view.backgroundColor = FQColor.dayBackgroundColor
        self.tableView.backgroundColor = FQColor.dayBackgroundColor
        let tableViewHeaderView = FQView(frame: CGRect(x: 0, y: 0, width: self.tableView.width, height: 15))
        tableViewHeaderView.roundCorners = [.topLeft, .topRight]
        tableViewHeaderView.backgroundColor = FQColor.dayForegroundColor
        self.tableView.tableHeaderView = tableViewHeaderView
        let tableViewFooterView = FQView(frame: CGRect(x: 0, y: 0, width: self.tableView.width, height: 15))
        tableViewFooterView.roundCorners = [.bottomLeft, .bottomRight]
        tableViewFooterView.backgroundColor = FQColor.dayForegroundColor
        self.tableView.tableFooterView = tableViewFooterView
        self.newQuoteButton.tintColor = FQColor.themeColor
        
        //fill up bottom safe area
        if(PHONE_TYPE == .iphone11 || PHONE_TYPE == .iphone11pro || PHONE_TYPE == .iphone11promax ||
           PHONE_TYPE == .iphone12 || PHONE_TYPE == .iphone12pro || PHONE_TYPE == .iphone12promax){
            let fillupView = UIView(frame: CGRect(x: 0, y: screenHeight - 34, width: screenWidth, height: 34))
            fillupView.backgroundColor = FQColor.dayForegroundColor
            self.view.addSubview(fillupView)
        }
    }
    
    func reloadData(){
        self.tableView.reloadData()
        if(AppDataManager.shared.quotes.count == 1){
            self.quoteCountLabel.text = "1 Quote"
        }else{
            self.quoteCountLabel.text = "\(AppDataManager.shared.quotes.count) Quotes"
        }
        AppDataManager.shared.syncQuotesWithCoreData()
    }
    
    @objc func didSelectOnAddQuote(_ sender: UIButton){
        let newQuoteViewController = NewQuoteViewController.init(nibName: "NewQuoteViewController", bundle: Bundle.main)
        newQuoteViewController.view.frame = self.view.bounds
        newQuoteViewController.data = Quote()
        newQuoteViewController.callback = {
            if(!newQuoteViewController.data!.isEmpty){
                AppDataManager.shared.quotes.append(newQuoteViewController.data!)
                self.reloadData()
            }
        }
        self.present(newQuoteViewController, animated: true, completion: nil)
    }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDataManager.shared.quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier, for: indexPath) as! QuoteTableViewCell
        let data = AppDataManager.shared.quotes[indexPath.item]
        cell.data = data
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = AppDataManager.shared.quotes[indexPath.item]
        let quoteHeight = Util.heightForView(text: data.quote, font: UIFont.systemFont(ofSize: 17), width: screenWidth - 60)
        return quoteHeight + 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newQuoteViewController = NewQuoteViewController.init(nibName: "NewQuoteViewController", bundle: Bundle.main)
        newQuoteViewController.view.frame = self.view.bounds
        newQuoteViewController.data = AppDataManager.shared.quotes[indexPath.item]
        newQuoteViewController.callback = {
            if(newQuoteViewController.data!.isEmpty){
                AppDataManager.shared.quotes.remove(at: indexPath.item)
            }
            self.reloadData()
        }
        self.present(newQuoteViewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [self.deleteQuote(at: indexPath)])
    }
    
    func deleteQuote(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            AppDataManager.shared.quotes.remove(at: indexPath.item)
            self.reloadData()
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
            completion(true)
        }
        action.image = UIImage(systemName: "trash")!.withTintColor(.white)
        action.backgroundColor = FQColor.themeColor
        return action
    }
}
