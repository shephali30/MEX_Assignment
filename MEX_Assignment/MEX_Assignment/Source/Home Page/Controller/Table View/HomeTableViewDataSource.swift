//
//  HomeCollectionViewDataSource.swift
//  MEX_Assignment
//
//  Created by Shephali Srivas on 29/05/22.
//

import UIKit

class HomeTableViewDataSource: NSObject, UITableViewDataSource {
    var botList:[Bot] = [Bot]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return botList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellIdentifier", for: indexPath) as? HomeTableViewCell {
            cell.botName.text = botList[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
}
