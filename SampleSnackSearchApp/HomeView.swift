import SwiftUI

struct HomeView: View {
	@ObservedObject var snackDataList = SnackData()
	@State var inputText = ""
	@State var showDetail = false

	var body: some View {
		VStack {
			TextField("キーワードを入力してください", text: $inputText, onCommit: {
				snackDataList.searchSnack(keyword: inputText)
			})
			.padding()

			List(snackDataList.snackList) { snack in
				Button(action: {
					showDetail.toggle()
				}, label: {
					HStack {
						Image(uiImage: snack.image)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(height: 40)
						Text(snack.name)
					}
				})
				.sheet(isPresented: self.$showDetail, content: {
					DetailView(url: snack.link)
				})
				.edgesIgnoringSafeArea(.bottom)
			}
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
