import UIKit
import Firebase

class SignUpController: UIViewController {
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

	private lazy var fullnameContainerView: UIView = {
		return UIView().inputContainerView(img: UIImage(systemName: "person.circle")!, txtField: fullnameTextField)
	}()

	private lazy var passwordContainerView: UIView = {
		return UIView().inputContainerView(img: UIImage(systemName: "lock")!, txtField: passwordTextField)
	}()

	private lazy var accountTypeContainerView: UIView = {
		let view = UIView().inputContainerView(img: UIImage(systemName: "person.crop.circle.badge.questionmark")!, segmentedControl: accountTypeSegmentedControl)
		view.heightAnchor.constraint(equalToConstant: 80).isActive = true
		return view
	}()


	private let emailTextField: UITextField = {
		let txtField =  UITextField().textField(withPlaceholder: "Email", inSecureTextEntry: false)
		txtField.autocapitalizationType = .none
		return txtField
	}()

	private let fullnameTextField: UITextField = {
		let txtField =  UITextField().textField(withPlaceholder: "Fullname", inSecureTextEntry: false)
		txtField.autocapitalizationType = .none
		return txtField
	}()

	private let passwordTextField: UITextField = {
		return UITextField().textField(withPlaceholder: "Password", inSecureTextEntry: true)
	}()


	private let accountTypeSegmentedControl: UISegmentedControl = {
		let sc = UISegmentedControl(items: ["Rider", "Driver"])
		sc.backgroundColor = .backgroundColor
		sc.tintColor = UIColor(white: 1, alpha: 0.87)
		sc.selectedSegmentIndex = 0
		return sc
	}()

	private let signUpButton: AuthButton = {
		let button = AuthButton(type: .system)
		button.setTitle("Sign Up", for: .normal)
		button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
		return button
	}()

	private let alreadyHaveAccountButton: UIButton = {
		let button = UIButton(type: .system)
		let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
			NSAttributedString.Key.foregroundColor: UIColor.lightGray
		])
		attributedTitle.append(NSAttributedString(string: " Log In", attributes: [
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
			NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint
		]))

		button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
		button.setAttributedTitle(attributedTitle, for: .normal)
		return button
	}()


	//MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()

		configureUI()
	}


	//MARK: - Selectors
	func configureUI() {
//		configureNavigationBar()
		self.view.backgroundColor = .backgroundColor

		self.view.addSubview(titleLabel)
		titleLabel.anchor(top: self.view.safeAreaLayoutGuide.topAnchor)
		titleLabel.centerX(inView: self.view)

		let stack = UIStackView(arrangedSubviews: [emailContainerView, fullnameContainerView, passwordContainerView, accountTypeContainerView, signUpButton])
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.spacing = 20

		self.view.addSubview(stack)
		stack.anchor(top: titleLabel.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)

		self.view.addSubview(alreadyHaveAccountButton)
		alreadyHaveAccountButton.centerX(inView: self.view)
		alreadyHaveAccountButton.anchor(bottom: self.view.bottomAnchor, paddingBottom: 25, height: 32)
	}

	@objc func handleShowLogin() {
//		let controller = LoginController()
//		navigationController?.pushViewController(controller, animated: true)
		navigationController?.popViewController(animated: true) // navigationController는 뷰가 스택으로 쌓인다. 
	}
	
	@objc func handleSignUp() {
		guard let email = emailTextField.text else { return }
		guard let password = passwordTextField.text else { return }
		guard let fullname = fullnameTextField.text else { return }
		let accountType = accountTypeSegmentedControl.selectedSegmentIndex
		
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if let error = error {
				print("fail to register error \(error)")
				return
			}
			
			guard let uid = result?.user.uid else { return }
			let values = ["email": email, "fullname": fullname, "accountType": accountType] as [String: Any]
			
			Database.database(url: "https://uberclone-2472f-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child("users").child(uid).updateChildValues(values) { error, ref in
				print("Successfully registered user and saved data...")
				self.emailTextField.text = ""
				self.passwordTextField.text = ""
				self.accountTypeSegmentedControl.selectedSegmentIndex = 0
			}
		}
		
	}
}
