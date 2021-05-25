//
//  ContentView.swift
//  Core
//
//  Created by Daniel Tarazona on 2/05/21.
//


import UIKit

class MyViewController: UIViewController {

    private var titleView: TextView = {
        let view = TextView()
        view.viewModel = TextViewModel(
            title: "Hello World"
        )
        return view
    }()

    private var subtitleView: TextView = {
        let view = TextView()
        return view
    }()

    override func viewDidLoad() {
        view.addSubview(titleView)
    }
}

#if DEBUG
import SwiftUI

struct MyViewControllerRepresentable: UIViewControllerRepresentable {

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {

    }

    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        MyViewController()
    }
}

@available(iOS 13.0, *)
struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        MyViewControllerRepresentable()
    }
}
#endif


