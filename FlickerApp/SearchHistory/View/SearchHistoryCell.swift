// This class is used to configure collection view cell

import UIKit

class SearchHistoryCell: UITableViewCell {
    
    // MARK: - IBOutlets -
    @IBOutlet weak var searchedLabel: UILabel!
    
    // MARK: - Properties -
    var searchedText: String? {
        didSet{
            setText(text: searchedText)
        }
    }
    
    private func setText(text: String?) {
        searchedLabel.text = text
    }
}
