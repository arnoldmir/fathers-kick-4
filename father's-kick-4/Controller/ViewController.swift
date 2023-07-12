import UIKit

extension ViewController {
    enum SectionType: Hashable {
        case solo
    }
    
    enum RowType: Int, CaseIterable, Hashable {
        case first
        case second
        case third
        case fourth
        case fifth
        case sixth
        case seventh
        case eighth
        case ninth
        case tenth
        case eleventh
        case twelfth
        case thirteenth
        case fourteenth
        case fifteenth
        case sixteenth
        case seventeenth
        case eighteenth
        case nineteenth
        case twentieth
        case twentyFirst
        case twentySecond
        case twentyThird
        case twentyFourth
        case twentyFifth
        case twentySixth
        case twentySeventh
        case twentyEighth
        case twentyNinth
        case thirtieth
        
        var title: String {
            return "\(rawValue)"
        }
    }
}

struct SectionTypeModel: Hashable {
    let rowType: ViewController.RowType
    var isSelected: Bool
}

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var sectionTypeModel: [SectionTypeModel] = []
    private var selectedRowType: RowType?
    private lazy var diffableDataSource: UITableViewDiffableDataSource<SectionType, SectionTypeModel> = {
        let dataSource = UITableViewDiffableDataSource<SectionType, SectionTypeModel>(tableView: tableView) { tableView, indexPath, model in
            let cell: SimpleTableViewCell = tableView.dequeueCell(for: indexPath)
            cell.configure(with: model)
            
            return cell
        }

        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        RowType.allCases.forEach({ sectionTypeModel.append(SectionTypeModel(rowType: $0, isSelected: false)) })
        configureDiffableSnapshot()
    }
    
    @IBAction private func shuffleButtonPressed(_ sender: Any) {
        sectionTypeModel.shuffle()
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionTypeModel>()
        
        snapshot.deleteAllItems()
        snapshot.appendSections([.solo])
        snapshot.appendItems(sectionTypeModel, toSection: .solo)
        
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

private extension ViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.register(SimpleTableViewCell.self)
        tableView.layer.cornerRadius = 16
    }
    
     func configureDiffableSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionTypeModel>()
        
        snapshot.appendSections([.solo])
        snapshot.appendItems(sectionTypeModel, toSection: .solo)
        
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isSelectedRow = sectionTypeModel[indexPath.row].isSelected
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionTypeModel>()
        
        sectionTypeModel[indexPath.row].isSelected = !isSelectedRow
        
        if !isSelectedRow {
            sectionTypeModel.insert(sectionTypeModel.remove(at: indexPath.row), at: 0)
        }
        
        snapshot.appendSections([.solo])
        snapshot.appendItems(sectionTypeModel, toSection: .solo)
        
        diffableDataSource.apply(snapshot, animatingDifferences: indexPath.row != 0 && !isSelectedRow)
    }
}
