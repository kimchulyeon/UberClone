import UIKit

class LoginController: UIViewController {

	//MARK: - Properties
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "UBER"
		label.font = UIFont(name: "Avenir-Light", size: 36)
		label.textColor = UIColor(white: 1, alpha: 0.8)
		return label
	}()
	
	// lazy var로 해줘야 밖에 View에 접근 가능하다.
	private lazy var emailContainerView: UIView = {
		let view = UIView().inputContainerView(img: UIImage(systemName: "envelope")!, txtField: emailTextField)
		view.heightAnchor.constraint(equalToConstant: 50).isActive = true // 스택뷰를 사용하면 그 안의 뷰 하나는 높이값을 가지고 있어야한다.
		return view
	}()
	
	private lazy var passwordContainerView: UIView = {
		return UIView().inputContainerView(img: UIImage(systemName: "lock")!, txtField: passwordTextField)
	}()
	
	private let emailTextField: UITextField = {
		return UITextField().textField(withPlaceholder: "Email", inSecureTextEntry: false)
	}()
	
	private let passwordTextField: UITextField = {
		return UITextField().textField(withPlaceholder: "Password", inSecureTextEntry: true)
	}()
	
	
	//MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
		
		self.view.addSubview(titleLabel)
		titleLabel.anchor(top: self.view.safeAreaLayoutGuide.topAnchor)
		titleLabel.centerX(inView: self.view)
		
//		self.view.addSubview(emailContainerView)
//		emailContainerView.anchor(top: titleLabel.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16, height: 50 )
//
//		self.view.addSubview(passwordContainerView)
//		passwordContainerView.anchor(top: emailContainerView.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 50 )
		
		let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.spacing = 16
		
		self.view.addSubview(stack)
		stack.anchor(top: titleLabel.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
												   
		
	}
	
	// 상태바 색상
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}
