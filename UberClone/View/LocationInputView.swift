import UIKit

protocol LocationInputViewDelegate: AnyObject {
	func dismissLocationInputView()
}

class LocationInputView: UIView {

	weak var delegate: LocationInputViewDelegate?

	//MARK: - 프로퍼티
	private lazy var backButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal), for: .normal)
		button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
		return button
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "KIM"
		label.font = UIFont.systemFont(ofSize: 18)
		label.textColor = .darkGray
		return label
	}()

	private lazy var startLocationIndicatorView: UIView = {
		let view = UIView()
		view.backgroundColor = .lightGray
		return view
	}()

	private lazy var linkingView: UIView = {
		let view = UIView()
		view.backgroundColor = .darkGray
		return view
	}()

	private lazy var destinationIndicatorView: UIView = {
		let view = UIView()
		view.backgroundColor = .black
		return view
	}()

	private lazy var startLocationTextField: UITextField = {
		let tf = UITextField()
		tf.attributedPlaceholder = NSAttributedString(string: "Current Location", attributes: [
			NSAttributedString.Key.foregroundColor: UIColor.gray
		])
		tf.backgroundColor = UIColor(red: 0.8863, green: 0.8863, blue: 0.8863, alpha: 1.0)
		tf.font = UIFont.systemFont(ofSize: 14)
		tf.isEnabled = false
		return tf
	}()

	private lazy var endLocationTextField: UITextField = {
		let tf = UITextField()
		tf.attributedPlaceholder = NSAttributedString(string: "Enter a destination", attributes: [
			NSAttributedString.Key.foregroundColor: UIColor.gray
		])
		tf.backgroundColor = .lightGray
		tf.returnKeyType = .search
		tf.font = UIFont.systemFont(ofSize: 14)
		return tf
	}()

	//MARK: - 라이프사이클
	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .white
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.55
		layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
		layer.masksToBounds = false

		addSubview(backButton)
		backButton.anchor(top: topAnchor, left: leadingAnchor, paddingTop: 44, paddingLeft: 19, width: 24, height: 25)

		addSubview(titleLabel)
		titleLabel.centerY(inView: backButton)
		titleLabel.centerX(inView: self)

		addSubview(startLocationTextField)
		startLocationTextField.anchor(top: backButton.bottomAnchor, left: leadingAnchor, right: trailingAnchor, paddingTop: 8, paddingLeft: 40, paddingRight: 40, height: 30)

		addSubview(endLocationTextField)
		endLocationTextField.anchor(top: startLocationTextField.bottomAnchor, left: leadingAnchor, right: trailingAnchor, paddingTop: 12, paddingLeft: 40, paddingRight: 40, height: 30)

		addSubview(startLocationIndicatorView)
		startLocationIndicatorView.setDimension(height: 6, width: 6)
		startLocationIndicatorView.layer.cornerRadius = 6 / 2
		startLocationIndicatorView.centerY(inView: startLocationTextField, leftAnchor: leadingAnchor, paddingLeft: 20)

		addSubview(destinationIndicatorView)
		destinationIndicatorView.setDimension(height: 6, width: 6)
		destinationIndicatorView.layer.cornerRadius = 6 / 2
		destinationIndicatorView.centerY(inView: endLocationTextField, leftAnchor: leadingAnchor, paddingLeft: 20)

		addSubview(linkingView)
		linkingView.centerX(inView: startLocationIndicatorView)
		linkingView.anchor(top: startLocationIndicatorView.bottomAnchor, bottom: destinationIndicatorView.topAnchor, paddingTop: 4, paddingBottom: 4, width: 0.5)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	//MARK: - Selectors
	@objc func handleBackTapped() {
		delegate?.dismissLocationInputView()
	}
}
