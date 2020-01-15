//
//  RunLogVC.swift
//  Treads
//
//  Created by Amr on 11/11/19.
//  Copyright © 2019 Amr. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController {

    @IBOutlet weak var runLogTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        runLogTableview.delegate = self
        runLogTableview.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        runLogTableview.reloadData()
    }
}

extension RunLogVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell") as? RunLogCell {
        guard let runn = Run.getAllRuns()?[indexPath.row] else { return RunLogCell() }
            cell.configure(Run: runn)
            return cell
       } else { return RunLogCell() }
   }
}
