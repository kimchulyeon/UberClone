import UIKit
import Firebase

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
		let txtField = UITextField().textField(withPlaceholder: "Email", inSecureTextEntry: false)
		txtField.autocapitalizationType = .none
		return txtField
	}()

	private let passwordTextField: UITextField = {
		return UITextField().textField(withPlaceholder: "Password", inSecureTextEntry: true)
	}()

	private let loginButton: AuthButton = {
		let button = AuthButton(type: .system)
		button.setTitle("Log In", for: .normal)
		button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
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

		configureNavigationBar()
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
	
	@objc func handleLogin() {
		guard let email = emailTextField.text else { return }
		guard let password = passwordTextField.text else { return }
		
		Auth.auth().signIn(withEmail: email, password: password) { result, error in
			if let error = error {
				print(":::::: DEBUG :::::: Failed to log user in with error \(error.localizedDescription)")
				return
			}
			
//			print("Successfully logged user in")
			
//			let keyWindows = UIApplication.shared.windows.first { $0.isKeyWindow }
//			guard let controller = keyWindows?.rootViewController as? HomeController else { return }
//			controller.configureUI()
//			self.dismiss(animated: true)
			
//			guard let controller = UIApplication.shared.keyWindow?.rootViewController as? HomeController else { return }
//			controller.configureUI()
//			self.dismiss(animated: true)
			
			let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
			.map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
			
			if let homeController = keyWindow?.rootViewController as? HomeController { homeController.configureUI()}
			self.dismiss(animated: true, completion: nil)
		}
	}

	
	//MARK: - Helper Functions
	func configureUI() {
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
