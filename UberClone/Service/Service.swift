import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_DRIVER_LOCATIONS = DB_REF.child("driver-location")

struct Service {
	// 📌 static을 사용하면 타입에 직접 사용해서 인스턴스를 생성하지 않는다. (불 필요한 인스턴스 생성을 방지)
	static let shared = Service()
	let currentUid = Auth.auth().currentUser?.uid

	//MARK: - 사용자 데이터를 가져오는 함수
	// Model에 User타입
	func fetchUserData(completion: @escaping (User) -> Void) {
		REF_USERS.child(currentUid!).observeSingleEvent(of: .value, with: { (snapshot) in
			// 📌 타입캐스팅으로 dictionary를 array로 변경
			guard let snp = snapshot.value as? [String: Any] else { return }
			let user = User(dictionary: snp)
			completion(user)
			
//			guard let fullname = snp["fullname"] else { return }
//			completion(fullname as! String)
		})
	}
}
