//
//  TableViewController.swift
//  MW1_Jarrell_Cliff
//
//  Created by Clifford Kyle Jarrell on 9/24/18.
//  Copyright © 2018 OSU CS Department. All rights reserved.
//

import UIKit

// display the lap times in a list and the average time in the lower toolbar

class TableViewController: UITableViewController {
    
    var lapTimes: [Time]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup toolbar items
        let uibbiFlexLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let uibbiAverageLapTime = UIBarButtonItem(title: "Average Lap Time: ", style: .plain, target: self, action: nil)
        let uibbiTime = UIBarButtonItem(title: getAverageLapTime(), style: .plain, target: self, action: nil)
        let uibbiFlexRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        self.toolbarItems = [uibbiFlexLeft, uibbiAverageLapTime,uibbiTime, uibbiFlexRight]
        
        
        // show top navigation bar and toolbar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Lap Times"
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    // gives the average time of the lap times
    func getAverageLapTime() -> String {
        
        // figure the total tenth seconds
        var totalTenths: Int = 0;
        for lapTime in lapTimes! {
            totalTenths += lapTime.timeInTenths
        }
        
        if lapTimes!.count != 0 {
            totalTenths /= lapTimes!.count
        }
        
        return Time(tenths: totalTenths).time
    }

    // return number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // return number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimes!.count
    }

    // populate the table with lap times
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table Cell", for: indexPath)
        
        cell.textLabel?.text = "Lap " + String(indexPath.row+1) + ": " + lapTimes![indexPath[1]].time
        
        return cell
    }
}
