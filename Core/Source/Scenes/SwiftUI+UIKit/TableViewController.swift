//
//  TableViewController.swift
//  Core
//
//  Created by Daniel Tarazona on 2/05/21.
//

import UIKit

class MyTableViewController: UITableViewController { }

enum OptVariation: String {
    case control = "Control"
    case variation = "Variation"
    case variation1 = "Variation1"
    case variation2 = "Variation2"
    case variation3 = "Variation3"
    case variation4 = "Variation4"
}

#if DEBUG
import SwiftUI

final class MyTableViewControllerRepresentable: UIViewControllerRepresentable {

    var vc: UITableViewController?

    func updateUIViewController(
        _ uiViewController: UITableViewController,
        context: Context
    ) {
        uiViewController.tableView.reloadData()
    }

    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UITableViewController {
        let tvc = MyTableViewController()
        tvc.tableView.delegate = context.coordinator
        tvc.tableView.dataSource = context.coordinator

        tvc.tableView.rowHeight = UITableView.automaticDimension
        tvc.tableView.estimatedRowHeight = UITableView.automaticDimension
        tvc.tableView.separatorStyle = .none
        tvc.tableView.allowsSelection = false
        tvc.tableView.allowsSelectionDuringEditing = true
        tvc.tableView.allowsMultipleSelectionDuringEditing = false

        tvc.tableView.register(TableCellView.self, forCellReuseIdentifier: "TableCellView")

        self.vc = tvc
        return tvc
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(data: ["Hello", "World"])
    }

    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {

        var data: [String]

        private lazy var headerView: UIStackView = {
            let stackView = UIStackView(
                axis: .vertical,
                subviews: [titleView]
            )

            stackView.add(subtitleView)
            return stackView
        }()

        private lazy var titleView: TextView = {
            let view = TextView()
            view.viewModel = TextViewModel(
                size: 24,
                title: "Upgrade today for free",
                bold: true
            )
            return view
        }()

        private lazy var subtitleView: TextView = {
            let view = TextView()
            view.viewModel = TextViewModel(
                title: "Get the benefits that you have today, plus advanced features like credit monitoring, dispute resolution, and monthly three bureau credit reports."
            )
            return view
        }()

        init(data: [String]) {
            self.data = data
        }

        // MARK: UITableViewDelegate and DataSource methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let dataRow = data[indexPath.row]
            let cell = TableCellView()
            cell.viewModel = TableCellViewModel(title: dataRow)
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return headerView
        }

        var cellHeights = [IndexPath: CGFloat]()

        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cellHeights[indexPath] = cell.frame.size.height
        }

        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    }
}

@available(iOS 13.0, *)
struct TablePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        MyTableViewControllerRepresentable()
    }
}
#endif

