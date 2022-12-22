import UIKit

class LocationTableCell: UITableViewCell {
	//MARK: - 프로퍼티
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "123 Main Street"
		label.font = UIFont.systemFont(ofSize: 14)
		return label
	}()
	
	private lazy var addressLabel: UILabel = {
		let label = UILabel()
		label.text = "123 Main Street, Washington, DC"
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = .lightGray
		return label
	}()

	//MARK: - 라이프사이클

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		selectionStyle = .none
		
		let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.spacing = 4
		
		addSubview(stack)
		stack.centerY(inView: self, leftAnchor: leadingAnchor, paddingLeft: 12)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
