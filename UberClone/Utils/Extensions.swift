import UIKit

/**
	- UIView > UILabel : titleLabel.anchor()가 가능
	- width와 height는 Label같은 경우 값을 주지 않으면 알아서 크기를 지정해주기 때문에 nil을 default값으로 한다.
	- right | bottom은 음수로 작성해줘야한다.
 */
extension UIView {

	//MARK: - Constraint 작업 함수
	/// constraint 반복 작업 함수
	func anchor(top: NSLayoutYAxisAnchor? = nil,
	            left: NSLayoutXAxisAnchor? = nil,
	            bottom: NSLayoutYAxisAnchor? = nil,
	            right: NSLayoutXAxisAnchor? = nil,
	            paddingTop: CGFloat = 0,
	            paddingLeft: CGFloat = 0,
	            paddingBottom: CGFloat = 0,
	            paddingRight: CGFloat = 0,
	            width: CGFloat? = nil,
	            height: CGFloat? = nil) {

		self.translatesAutoresizingMaskIntoConstraints = false

		if let top = top {
			self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
		}

		if let left = left {
			self.leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
		}

		if let right = right {
			self.trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
		}

		if let bottom = bottom {
			self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
		}

		if let width = width {
			self.widthAnchor.constraint(equalToConstant: width).isActive = true
		}

		if let height = height {
			self.heightAnchor.constraint(equalToConstant: height).isActive = true
		}

	}
	/// constraint 반복 작업 함수 centerX
	func centerX(inView view: UIView) {
		self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	/// constraint 반복 작업 함수 centerY
	func centerY(inView view: UIView, constant: CGFloat = 0) {
		self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
	}


	//MARK: - Container 생성 함수
	/// email, password Container 생성 함수
	func inputContainerView(img: UIImage, txtField: UITextField? = nil, segmentedControl: UISegmentedControl? = nil) -> UIView {
		let view = UIView()

		// 이메일 컨테이너 뷰 안에만 쓰이는 이미지여서 내부에 선언
		let imageView = UIImageView()
		imageView.image = img
		imageView.alpha = 0.87
		imageView.tintColor = .lightGray

		view.addSubview(imageView)

		if let txtField = txtField {
			imageView.centerY(inView: view) // 여기서 view는 emailContainer다
			imageView.anchor(left: view.leadingAnchor, paddingLeft: 8, width: 24, height: 24)
			imageView.contentMode = .scaleAspectFill

			view.addSubview(txtField)
			txtField.anchor(left: imageView.trailingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingLeft: 8, paddingBottom: 8)
			txtField.centerY(inView: view)
		}

		if let sc = segmentedControl {
			// 텍스트필드일 때랑 세그멘트일 때랑 이미지뷰가 다른 constraint이기 때문에 분기 처리
			imageView.anchor(top: view.topAnchor, left: view.leadingAnchor, paddingTop: -10, paddingLeft: 8, width: 24, height: 24)
			imageView.contentMode = .scaleAspectFill
			view.addSubview(sc)
			sc.anchor(left: view.leadingAnchor, right: view.trailingAnchor, paddingLeft: 8, paddingRight: 8)
			sc.centerY(inView: view, constant: 8)
		}

		// 구분선
		let separatorView = UIView()
		separatorView.backgroundColor = .lightGray
		view.addSubview(separatorView)
		separatorView.anchor(left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingLeft: 8, height: 0.75)


		return view
	}
}



extension UITextField {

	func textField(withPlaceholder placeholder: String, inSecureTextEntry: Bool) -> UITextField {
		let tf = UITextField()
		tf.borderStyle = .none
		tf.font = UIFont.systemFont(ofSize: 16)
		tf.textColor = .white
		tf.keyboardAppearance = .dark
		tf.isSecureTextEntry = inSecureTextEntry
		tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
		return tf
	}

}



extension UIColor {
	static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
		return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
	}

	static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
	static let mainBlueTint = UIColor.rgb(red: 17, green: 154, blue: 237)
}
