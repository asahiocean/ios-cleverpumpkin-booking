import UIKit
import SwiftUI

public var rowHeight: CGFloat = UIScreen.main.bounds.height/10
public var estimatedRowHeight: CGFloat = UIScreen.main.bounds.height/10

class TableViewController: UITableViewController {
    
    private var posts: [Hotel]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        posts = Handler.getdb()
        tableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier)
        setup()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = (tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell) {
            cell.set(hotel: posts[indexPath.row])
            return cell
        } else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: CustomCell.identifier)
            cell.backgroundColor = UIColor.systemRed
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScreen = DetailScreen(object: posts[indexPath.row])
        let host = UIHostingController(rootView: detailScreen)
        navigationController?.pushViewController(host, animated: true)
    }
}

extension TableViewController {
    internal func setup() {
        activityIndicator()
        tableViewConfig()
        navigationBar()
    }
    
    internal func activityIndicator() {
        let activityView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityView
        activityView.startAnimating()
    }
    
    internal func navigationBar() {
        navigationItem.title = "Hotels"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    internal func tableViewConfig() {
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = rowHeight
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.decelerationRate = .fast
    }
}
