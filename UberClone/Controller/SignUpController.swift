import UIKit

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
		view.heightAnchor.constraint(equalToConstant: 80).isActive = true // 스택뷰를 사용하면 그 안의 뷰 하나는 높이값을 가지고 있어야한다.
		return view
	}()
	
	private lazy var fullnameContainerView: UIView = {
		return UIView().inputContainerView(img: UIImage(systemName: "person.circle")!, txtField: fullnameTextField)
	}()

	private lazy var passwordContainerView: UIView = {
		return UIView().inputContainerView(img: UIImage(systemName: "lock")!, txtField: passwordTextField)
	}()
	
	private lazy var accountTypeContainerView: UIView = {
		return UIView().inputContainerView(img: UIImage(systemName: "person.2.badge.gearshape.fill")!, segmentedControl: accountTypeSegmentedControl)
	}()
	

	private let emailTextField: UITextField = {
		return UITextField().textField(withPlaceholder: "Email", inSecureTextEntry: false)
	}()
	
	private let fullnameTextField: UITextField = {
		return UITextField().textField(withPlaceholder: "Fullname", inSecureTextEntry: false)
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

		let stack = UIStackView(arrangedSubviews: [emailContainerView, fullnameContainerView, passwordContainerView, accountTypeContainerView])
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.spacing = 20

		self.view.addSubview(stack)
		stack.anchor(top: titleLabel.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
	}
}
