import SwiftUI

struct HomeView: View {
	@ObservedObject var snackDataList = SnackData()
	@State var inputText = ""

    var body: some View {
		VStack {
			TextField("キーワードを入力してください", text: $inputText, onCommit: {
				snackDataList.searchSnack(keyword: inputText)
			})
			.padding()

			List(snackDataList.snackList) { snack in
				HStack {
					Image(uiImage: snack.image)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(height: 40)
					Text(snack.name)
				}
			}
		}
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
