//
//  SubRedditView.swift
//  YARC
//
//  Created by Michael Kroneder on 09/02/2021.
//
import SafariServices
import SwiftUI

struct SubRedditView: View {
    @ObservedObject var viewModel: SubRedditViewModel

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    AsyncImageView(url: "",
                                   placeholder: {
                                       Text(R.string.localizable.isLoading_phrase())
                                   })
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                .padding([.leading, .top], 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading) {
                Text("displayNamePrefixed")
                    .font(.title3)
                    .padding(.bottom, 5)
                    .padding(.leading, 5)
                    .foregroundColor(Color.white)

                Text("subscribers")
                    .font(.body)
                    .padding(.bottom, 5)
                    .padding(.leading, 5)
                    .foregroundColor(Color.gray)

                Text("publicDescription")
                    .font(.footnote)
                    .padding(.leading, 5)
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)

            Divider()

            Spacer()

            PostsView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.getPosts()
        }
        .modifier(LoadingModifier(isShowing: $viewModel.isLoading))
    }
}

private struct ImageView: View {
    @State var callSafari: Bool = false
    var imageURL: String
    var url: String

    var body: some View {
        Button(action: {
            callSafari.toggle()
        }, label: {
            AsyncImageView(url: imageURL,
                           placeholder: {
                               Text(R.string.localizable.isLoading_phrase())
                           }).aspectRatio(contentMode: .fit)

        }).sheet(isPresented: $callSafari) {
            SafariView(url: URL(string: url)!)
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
