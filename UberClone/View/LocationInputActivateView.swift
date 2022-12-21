import UIKit

//MARK: - 프로토콜
protocol LocationInputActivateViewDelegate: AnyObject {
	func presentLocationInputView()
}

class LocationInputActivateView: UIView {
	
	weak var delegate: LocationInputActivateViewDelegate?
	
	//MARK: - Properties
	private let indicatorView: UIView = {
		let view = UIView()
		view.backgroundColor = .black
		return view
	}()
	
	private let placeholderLabel: UILabel = {
		let label = UILabel()
		label.text = "Where to?"
		label.font = UIFont.systemFont(ofSize: 18)
		label.textColor = .darkGray
		return label
	}()
	
	//MARK: - LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .white
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.55
		layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
		layer.masksToBounds = false
		
		addSubview(indicatorView)
		indicatorView.centerY(inView: self, leftAnchor: self.leadingAnchor, paddingLeft: 16)
		indicatorView.setDimension(height: 6, width: 6)
		
		addSubview(placeholderLabel)
		placeholderLabel.centerY(inView: self, leftAnchor: indicatorView.leadingAnchor, paddingLeft: 20)
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapIndicator))
		addGestureRecognizer(tap)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Selectors
	@objc func handleTapIndicator() {
		delegate?.presentLocationInputView()
	}
}
