import Foundation

class SnackData: ObservableObject {

	struct Item: Codable {
		let name: String?
		let url: URL?
		let image: URL?
	}

	struct ResultJson: Codable {
		let item: [Item]?
	}

	func searchSnack(keyword: String) {
		print(keyword)

		guard let keyword_ecode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
			return
		}

		guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_ecode)&max=10&order=r") else {
			return
		}

		print(req_url)

		let req = URLRequest(url: req_url)
		let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
		let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
			session.finishTasksAndInvalidate()

			do {
				let decoder = JSONDecoder()
				let json = try decoder.decode(ResultJson.self, from: data!)
				print(json)
			} catch {
				print("Error has occurred")
			}
		})
		task.resume()
	}
}
