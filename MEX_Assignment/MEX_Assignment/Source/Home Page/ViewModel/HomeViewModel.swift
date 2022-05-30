//
//  HomeViewModel.swift
//  MEX_Assignment
//
//  Created by Shephali Srivas on 29/05/22.
//

import Foundation
import UIKit

class HomeViewModel {
    //MARK: - Variable declaration and completion handler declaration
    var botList: [Bot] = [Bot]()
    var saveHandler: ((_ isSuccess: Bool) -> Void)?
    var sortedList: ((_ botList: [Bot]) -> Void)?
    
    //MARK: - Save name functionality
    func saveBotName(vc: UIViewController, botList: [Bot]) {
        self.botList = botList
        vc.alertWithInputField(title: "ADD BOT NAME", message: "Please enter BOT name", actionHandler: { text in
            if text == "" {
                vc.alert(message: "Please enter correct BOT name.", title: "ERROR")
            } else if self.botList.contains(where: { $0.name?.lowercased() == text?.lowercased() }) {
                vc.alert(message: "BOT name already saved", title: "ERROR")
            }else {
                self.saveBotNameToLocal(name: text ?? "", vc: vc)
            }
        })
    }
    
    func saveBotNameToLocal(name: String, vc: UIViewController) {
        let bot = Bot(name: name, date: Date().timeIntervalSince1970)
        self.botList.append(bot)
        if UserDefaultsHelper.shared.storeData(key: UserDefaultsKey.botKey, value: self.botList) {
            self.saveHandler?(true)
        } else {
            self.saveHandler?(false)
        }
    }
}
