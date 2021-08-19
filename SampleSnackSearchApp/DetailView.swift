import SwiftUI
import SafariServices

struct DetailView: UIViewControllerRepresentable {
	var url: URL

	func makeUIViewController(context: Context) -> SFSafariViewController {
		return SFSafariViewController(url: url)
	}

	func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
