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
		let view = UIView()
		
		// 이메일 컨테이너 뷰 안에만 쓰이는 이미지여서 내부에 선언
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "envelope")
		imageView.alpha = 0.87
		imageView.tintColor = .lightGray
		
		view.addSubview(imageView)
		imageView.centerY(inView: view) // 여기서 view는 emailContainer다
		imageView.anchor(left: view.leadingAnchor, paddingLeft: 8, width: 24 ,height: 24)
		imageView.contentMode = .scaleAspectFill
		
		view.addSubview(emailTextField)
		emailTextField.anchor(left: imageView.trailingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingLeft: 8,paddingBottom: 8)
		emailTextField.centerY(inView: view)
		
		// 구분선
		let separatorView = UIView()
		separatorView.backgroundColor = .lightGray
		view.addSubview(separatorView)
		separatorView.anchor(left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingLeft: 8, height: 0.75)
		
		return view
	}()
	
	private let emailTextField: UITextField = {
		let tf = UITextField()
		tf.borderStyle = .none
		tf.font = UIFont.systemFont(ofSize: 16)
		tf.textColor = .white
		tf.keyboardAppearance = .dark
		tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
		return tf
	}()
	
	
	//MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
		
		self.view.addSubview(titleLabel)
		titleLabel.anchor(top: self.view.safeAreaLayoutGuide.topAnchor)
		titleLabel.centerX(inView: self.view)
		
		self.view.addSubview(emailContainerView)
		emailContainerView.anchor(top: titleLabel.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16, height: 50 )
	}
	
	// 상태바 색상
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}
