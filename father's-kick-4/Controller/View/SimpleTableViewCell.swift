import UIKit

class SimpleTableViewCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var checkmarkImageView: UIImageView!

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        UIView.animate(withDuration: 0.15) {
            self.containerView.alpha = self.isHighlighted ? 0.3 : 1
            self.containerView.transform = self.isHighlighted ? .init(scaleX: 0.97, y: 0.97) : .identity
        }
    }

    func configure(with model: SectionTypeModel) {
        titleLabel.text = model.rowType.title
        checkmarkImageView.isHidden = !model.isSelected
    }
}
