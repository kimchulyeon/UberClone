import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {

	//MARK: - Propertie
	private let mapView = MKMapView()
	private let locationManager = CLLocationManager() // 위치 엑세스 허용을 묻는 메세지

	//MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		checkUserIsLoggedIn()
		enableLocationService()
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
		configureMapView()
	}
	
	func configureMapView() {
		view.addSubview(mapView)
 		mapView.frame = self.view.frame
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
	}
}

//MARK: - Location Service
extension HomeController: CLLocationManagerDelegate {
	func enableLocationService() {
		locationManager.delegate = self
		
		switch locationManager.authorizationStatus {
		case .notDetermined:
			print("DEBUG::: : Not determined...")
			locationManager.requestWhenInUseAuthorization()
		case .restricted, .denied:
			break
		case .authorizedAlways:
			print("DEBUG::: : Auth always...")
			locationManager.startUpdatingLocation()
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
		case .authorizedWhenInUse:
			print("DEBUG::: : Auth when in use...")
			locationManager.requestAlwaysAuthorization()
		@unknown default:
			break
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse {
			locationManager.requestAlwaysAuthorization()
		}
	}
}

