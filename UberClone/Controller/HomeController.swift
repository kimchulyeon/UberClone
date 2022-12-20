import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {

	//MARK: - Propertie
	private let mapView = MKMapView()

	//MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		checkUserIsLoggedIn()
//		signOut()
	}

	//MARK: - API
	func checkUserIsLoggedIn() {
		if Auth.auth().currentUser?.uid == nil {
			DispatchQueue.main.async {
				let nav = UINavigationController(rootViewController: LoginController())
				nav.modalPresentationStyle = .fullScreen
				self.present(nav, animated: false)
			}
		} else {
			configureUI()
		}
	}

	func signOut() {
		do {
			try Auth.auth().signOut()
		} catch {
			print(":::DEBUG::: Error signing out")
		}
	}
	
	
	//MARK: - Helper Functions·
	func configureUI() {
		view.addSubview(mapView)
		mapView.frame = self.view.frame
	}

}

