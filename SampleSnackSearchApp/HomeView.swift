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
		}
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
