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

	private let loginButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Log In", for: .normal)
		button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
		button.backgroundColor = .mainBlueTint
		button.layer.cornerRadius = 5
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
		button.heightAnchor.constraint(equalToConstant: 50).isActive = true
		return button
	}()

	private let dontHaveAccountButton: UIButton = {
		let button = UIButton(type: .system)
		let attributedTitle = NSMutableAttributedString(string: "Dont' have an account? ", attributes: [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
			NSAttributedString.Key.foregroundColor: UIColor.lightGray
		])
		attributedTitle.append(NSAttributedString(string: " Sign Up", attributes: [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
			NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint
		]))
		
		button.addTarget(self, action: #selector(handleShowSignup), for: .touchUpInside)
		button.setAttributedTitle(attributedTitle, for: .normal)
		return button
	}()


	//MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()

		configureUI()
	}

	
	//MARK: - Selectors
	/// Sign Up 컨트롤러를 생성해야하고
	/// 네비게이션 컨트롤러를 사용하여 이동할 수 있게 해야한다 // SceneDelegate.swift에서 rootViewController를 네비게이션으로 설정
	@objc func handleShowSignup() {
		// 세그웨이
		let controller = SignUpController()
		navigationController?.pushViewController(controller, animated: true)
	}

	//MARK: - Helper Functions
	func configureUI() {
		configureNavigationBar()
		self.view.backgroundColor = .backgroundColor

		self.view.addSubview(titleLabel)
		titleLabel.anchor(top: self.view.safeAreaLayoutGuide.topAnchor)
		titleLabel.centerX(inView: self.view)

		let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.spacing = 24

		self.view.addSubview(stack)
		stack.anchor(top: titleLabel.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)

		self.view.addSubview(dontHaveAccountButton)
		dontHaveAccountButton.centerX(inView: self.view)
		dontHaveAccountButton.anchor(bottom: self.view.bottomAnchor, paddingBottom: 25, height: 32)
	}
	
	/// navigationbar configuration
	/// preferredStatusBarStyle가 필요 없어짐
	func configureNavigationBar() {
		navigationController?.navigationBar.isHidden = true
		navigationController?.navigationBar.barStyle = .black
	}
}
