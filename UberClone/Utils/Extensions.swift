import UIKit

/**
	- UIView > UILabel : titleLabel.anchor()가 가능
	- width와 height는 Label같은 경우 값을 주지 않으면 알아서 크기를 지정해주기 때문에 nil을 default값으로 한다.
	- right | bottom은 음수로 작성해줘야한다.
 */
extension UIView {

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
	func centerY(inView view: UIView) {
		self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
		tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
		return tf
	}
	
}
