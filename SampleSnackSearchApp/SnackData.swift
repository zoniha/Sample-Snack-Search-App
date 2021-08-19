import Foundation
import UIKit

struct SnackItem: Identifiable {
	let id = UUID()
	let name: String
	let link: URL
	let image: UIImage
}

class SnackData: ObservableObject {

	struct Item: Codable {
		let name: String?
		let url: URL?
		let image: URL?
	}

	struct ResultJson: Codable {
		let item: [Item]?
	}

	@Published var snackList: [SnackItem] = []

	func searchSnack(keyword: String) {
		print(keyword)

		guard let keyword_ecode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
			return
		}

		guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_ecode)&max=10&order=r") else {
			return
		}

		let req = URLRequest(url: req_url)
		let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
		let task = session.dataTask(with: req, completionHandler: { (data, _, _) in
			session.finishTasksAndInvalidate()

			do {
				let decoder = JSONDecoder()
				let json = try decoder.decode(ResultJson.self, from: data!)

				if let items = json.item {
					self.snackList.removeAll()

					for item in items {
						if let name = item.name,
						   let link = item.url,
						   let imageUrl = item.image,
						   let imageData = try? Data(contentsOf: imageUrl),
						   let image = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal) {
							let snack = SnackItem(name: name, link: link, image: image)
							self.snackList.append(snack)
						}
					}
				}
			} catch {
				print("Error has occurred")
			}
		})
		task.resume()
	}
}
