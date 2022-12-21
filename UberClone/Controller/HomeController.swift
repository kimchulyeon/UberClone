import UIKit
import Firebase
import MapKit

private let reuseIdentifier = "LocationCell"

class HomeController: UIViewController {

	//MARK: - Propertie
	private let mapView = MKMapView()
	private let locationManager = CLLocationManager() // 위치 엑세스 허용을 묻는 메세지

	private let locationInputActivateView = LocationInputActivateView()
	private let locationInputView = LocationInputView()
	private final let LOCATIONINPUTVIEWHEIGHT: CGFloat = 200
	private let tableView = UITableView()


	//MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()

		locationInputActivateView.delegate = self
		locationInputView.delegate = self
		tableView.delegate = self
		tableView.dataSource = self

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

		view.addSubview(locationInputActivateView)
		locationInputActivateView.centerX(inView: view)
		locationInputActivateView.setDimension(height: 50, width: view.frame.width - 64)
		locationInputActivateView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
		locationInputActivateView.alpha = 0

		UIView.animate(withDuration: 1.4) {
			self.locationInputActivateView.alpha = 1
		}
		
		configureTableView()
	}

	func configureMapView() {
		view.addSubview(mapView)
		mapView.frame = self.view.frame
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
	}

	func configureLocationInputView() {
		view.addSubview(locationInputView)
		locationInputView.anchor(top: view.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, height: LOCATIONINPUTVIEWHEIGHT)
		locationInputView.alpha = 0

		UIView.animate(withDuration: 0.5, animations: {
			self.locationInputView.alpha = 1
		}) { _ in
			UIView.animate(withDuration: 0.4, animations: {
				self.tableView.frame.origin.y = self.LOCATIONINPUTVIEWHEIGHT // 이동
			})
		}
	}

	func configureTableView() {
		tableView.register(LocationTableCell.self, forCellReuseIdentifier: reuseIdentifier)
		tableView.rowHeight = 60
		let height = view.frame.height - LOCATIONINPUTVIEWHEIGHT
		tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: height) // 숨겨놓기
		
		view.addSubview(tableView)
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


extension HomeController: LocationInputActivateViewDelegate {
	func presentLocationInputView() {
		locationInputActivateView.alpha = 0
		configureLocationInputView()
	}
}


extension HomeController: LocationInputViewDelegate {
	func dismissLocationInputView() {
		UIView.animate(withDuration: 0.5, animations: {
			self.locationInputView.alpha = 0
			self.tableView.frame.origin.y = self.view.frame.height // 다시 숨기기
		}) { _ in
			UIView.animate(withDuration: 0.3, animations: {
				self.locationInputActivateView.alpha = 1
			})
		}
	}
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationTableCell
		return cell
	}
}
