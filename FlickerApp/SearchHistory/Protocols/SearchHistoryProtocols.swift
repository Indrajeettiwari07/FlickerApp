
import UIKit


// ======== Presenter ======== //
// VIEW -> PRESENTER
protocol SearchHistoryPresenterInput {
    func getHistory()
    func numberOfRowsInSection() -> Int
    func numberOfSections() -> Int
    func searchedText(for row:Int) -> String
    func heightForRow() -> CGFloat
}


// PRESENTER -> VIEW
protocol SearchHistoryPresenterOutput: class {
    func display()
    func displayError()
}
