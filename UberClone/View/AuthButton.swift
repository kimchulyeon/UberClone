import UIKit

// UITextField > func textField 처럼 함수로 해도 되고 AuthButton처럼 커스텀 클래스로 해도 된다.
class AuthButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
		self.backgroundColor = UIColor.mainBlueTint
		self.layer.cornerRadius = 5
		self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
