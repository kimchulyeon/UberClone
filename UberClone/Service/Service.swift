import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

struct Service {
	// 📌 static을 사용하면 타입에 직접 사용해서 인스턴스를 생성하지 않는다. (불 필요한 인스턴스 생성을 방지)
	static let shared = Service()
	let currentUid = Auth.auth().currentUser?.uid

	//MARK: - 사용자 데이터를 가져오는 함수
	func fetchUserData(completion: @escaping (String) -> Void) {
		REF_USERS.child(currentUid!).observeSingleEvent(of: .value, with: { (snapshot) in
			// 📌 타입캐스팅으로 dictionary를 array로 변경
			guard let snp = snapshot.value as? [String: Any] else { return }
			guard let fullname = snp["fullname"] else { return }
			completion(fullname as! String)
		})
	}
}
