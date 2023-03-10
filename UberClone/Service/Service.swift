import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_DRIVER_LOCATIONS = DB_REF.child("driver-location")

struct Service {
	// ๐ static์ ์ฌ์ฉํ๋ฉด ํ์์ ์ง์  ์ฌ์ฉํด์ ์ธ์คํด์ค๋ฅผ ์์ฑํ์ง ์๋๋ค. (๋ถ ํ์ํ ์ธ์คํด์ค ์์ฑ์ ๋ฐฉ์ง)
	static let shared = Service()
	let currentUid = Auth.auth().currentUser?.uid

	//MARK: - ์ฌ์ฉ์ ๋ฐ์ดํฐ๋ฅผ ๊ฐ์ ธ์ค๋ ํจ์
	// Model์ Userํ์
	func fetchUserData(completion: @escaping (User) -> Void) {
		REF_USERS.child(currentUid!).observeSingleEvent(of: .value, with: { (snapshot) in
			// ๐ ํ์์บ์คํ์ผ๋ก dictionary๋ฅผ array๋ก ๋ณ๊ฒฝ
			guard let snp = snapshot.value as? [String: Any] else { return }
			let user = User(dictionary: snp)
			completion(user)
			
//			guard let fullname = snp["fullname"] else { return }
//			completion(fullname as! String)
		})
	}
}
