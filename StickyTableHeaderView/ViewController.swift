// Created by Paulius Cesekas on 2020-03-17.

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var header: UIView!
    var offset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = UIView()
        tableView.tableHeaderView?.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.tableHeaderView = UIView(
            frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: header.bounds.height)
        )
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let diff = offset - tableView.contentOffset.y
        if tableView.contentOffset.y < 0 {
            header.transform = CGAffineTransform(translationX: 0, y: -self.tableView.contentOffset.y)
        } else if diff < 0 {
            if header.transform.ty > -header.bounds.height {
                header.transform = CGAffineTransform(translationX: 0, y: -self.tableView.contentOffset.y)
            } else {
                header.transform = CGAffineTransform(translationX: 0, y: -header.bounds.height)
            }
        } else {
            if header.transform.ty + diff < 0 {
                header.transform = CGAffineTransform(translationX: 0, y: header.transform.ty + diff)
            } else {
                header.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }        
        offset = tableView.contentOffset.y
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 999
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
