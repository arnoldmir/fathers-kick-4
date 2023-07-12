import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reuseId)
    }
    
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as? T else { fatalError("Check identifier: \(T.reuseId)") }
        
        return cell
    }
}
