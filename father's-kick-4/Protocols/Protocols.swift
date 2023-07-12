import UIKit

protocol ReusableProtocol where Self: UIView {
    static var reuseId: String { get }
}

extension ReusableProtocol {
    static var reuseId: String {
        return String(describing: self)
    }
}

protocol XibableProtocol where Self: UIView {
    static var nib: UINib { get }
    static var nibName: String { get }
}

extension XibableProtocol {
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
}

