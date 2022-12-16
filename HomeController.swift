import UIKit
import Firebase

class HomeController: UIViewController {

	//MARK: - Properties

	//MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		checkUserIsLoggedIn()
		self.view.backgroundColor = .yellow
	}

	//MARK: - API
	func checkUserIsLoggedIn() {
		if Auth.auth().currentUser?.uid == nil {
			DispatchQueue.main.async {
				print(":::DEBUG::: User is not logged in ....")
				let nav = UINavigationController(rootViewController: LoginController())
				nav.modalPresentationStyle = .fullScreen
				self.present(nav, animated: false)
			}
		} else {
			print(":::DEBUG::: User is logged in ... ")
			print(":::DEBUG::: UserId: \(String(describing: Auth.auth().currentUser?.uid))")
		}
	}

	func signOut() {
		do {
			try Auth.auth().signOut()
		} catch {
			print(":::DEBUG::: Error signing out")
		}
	}
}
