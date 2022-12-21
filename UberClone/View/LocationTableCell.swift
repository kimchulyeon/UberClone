import UIKit

class LocationTableCell: UITableViewCell {
	//MARK: - 프로퍼티
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "KIM"
		label.font = UIFont.systemFont(ofSize: 18)
		label.textColor = .darkGray
		return label
	}()

	//MARK: - 라이프사이클

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
