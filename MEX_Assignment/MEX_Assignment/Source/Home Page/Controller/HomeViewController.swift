//
//  HomeViewController.swift
//  MEX_Assignment
//
//  Created by Shephali Srivas on 29/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var sortedButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var botListTable: UITableView!
    
    //MARK: - Variable Declaration
    lazy var delegate: HomeTableViewDelegate = {
        return HomeTableViewDelegate()
    }()
    
    lazy var dataSource: HomeTableViewDataSource = {
        return HomeTableViewDataSource()
    }()
    
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    var botList:[Bot] = [Bot]()
    var searchList:[Bot] = [Bot]()
    var isASC: Bool = true

    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.initViewModel()
        self.reloadList()
        
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        self.botListTable.dataSource = dataSource
        self.botListTable.delegate = delegate
        self.botListTable.reloadData()
        self.searchTextField.addTarget(self, action: #selector(searchBotName(_ :)), for: .editingChanged)
    }
    
    func reloadList() {
        DispatchQueue.main.async {
            if let botList = UserDefaultsHelper.shared.fetchData(key: UserDefaultsKey.botKey) {
                self.nodataLabel.isHidden = true
                self.botListTable.isHidden = false
                if self.isASC {
                    self.botList = botList.sorted(by: {$0.date < $1.date})
                    self.sortedButton.setTitle("Sorted(ASC)", for: .normal)
                } else {
                    self.botList = botList.sorted(by: {$0.date > $1.date})
                    self.sortedButton.setTitle("Sorted(DESC)", for: .normal)
                }
                self.dataSource.botList = self.botList
                self.botListTable.reloadData()
            } else {
                self.nodataLabel.isHidden = false
                self.botListTable.isHidden = true
            }

        }
    }
    
    func reloadListBySearch(botList: [Bot]) {
        self.dataSource.botList = botList
        self.botListTable.reloadData()
    }
    
    //MARK: - Search Functionality
    
    @objc func searchBotName(_ textfield: UITextField) {
        self.searchList.removeAll()
        if let text = textfield.text?.lowercased(), text.count != 0 {
            if let searchList = self.botList.filter({ ($0.name?.lowercased().contains(text) ?? false) }) as? [Bot], searchList.count > 0 {
                self.searchList = searchList
                self.reloadListBySearch(botList: self.searchList)
                self.nodataLabel.isHidden = true
                self.botListTable.isHidden = false
            } else {
                self.nodataLabel.isHidden = false
                self.botListTable.isHidden = true
            }
        } else {
            self.nodataLabel.isHidden = true
            self.botListTable.isHidden = false
            self.reloadListBySearch(botList: self.botList)
        }
    }
    
    // MARK: - ViewModel functionality
    private func initViewModel() {
        self.viewModel.saveHandler = { isSuccess in
            if isSuccess {
                self.reloadList()
            } else {
                self.alert(message: "BOT name is not saved.", title: "ERROR")
            }
        }
        
        self.viewModel.sortedList = { botList in
            self.botList = botList
            self.reloadList()
        }
    }
    
    // MARK: - Actions
    @IBAction func sortTapAction(_ sender: Any) {
        isASC = !isASC
        self.reloadList()
    }
    
    @IBAction func AddBotTapAction(_ sender: Any) {
        viewModel.saveBotName(vc: self, botList: self.botList)
    }
}
