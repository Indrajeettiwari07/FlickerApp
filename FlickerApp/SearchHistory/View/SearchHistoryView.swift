// This class is used to show search history in table view
// This class is used to creat UI and adjust it.

import UIKit

class SearchHistoryView: UIViewController {
    
    // MARK: - Properties -
    var presenter: SearchHistoryPresenter?
    
    // MARK: IBOUTLets
    @IBOutlet weak var tableView: UITableView!
}


// MARK: Life Cycle
extension SearchHistoryView {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Translation.SearchHistory.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getHistory()
    }
}


// MARK: UITableView Delegates
extension SearchHistoryView: UITableViewDelegate {
    
    // Method to capture row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter?.heightForRow() ?? 0.0
    }
}


// MARK: UITableView DataSource
extension SearchHistoryView: UITableViewDataSource {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    
    // Number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    
    // Configure Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryCell.reusableIdentifier) as? SearchHistoryCell  else {    return UITableViewCell() }
        cell.searchedText = presenter?.searchedText(for: indexPath.row)
        return cell
    }
}


// MARK: Display Logic
// PRESENTER -> VIEW
extension SearchHistoryView: SearchHistoryPresenterOutput, AlertService {
    
    func display() {
        GCD.runOnMainThread {
            self.tableView.reloadData()
        }
    }
    
    // Display Error
    func displayError() {
        GCD.runOnMainThread {
            self.showAlert(titleStr: Translation.StringConstant.error, messageStr: "There is no serch history now.", okButtonTitle: Translation.StringConstant.ok, cancelButtonTitle: nil, response: nil)
        }
    }
}
