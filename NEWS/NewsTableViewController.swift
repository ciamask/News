//
//  NewsTableViewController.swift
//  NEWS
//
//  Created by Shreeya Maskey on 9/16/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
//        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell does not exist")
        }

        cell.titleLabel.text = self.articles[indexPath.row].title
        cell.descriptionLabel.text = self.articles[indexPath.row].description

        return cell

    }

    private func populateNews() {

//        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=c1cec0643f4d45d08fee049527f860b4")!

//        let resource = Resource<ArticlesList>(url: url)

        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: { [weak self] result in   //subscribed to the observable returned
                if let result = result {
                    self?.articles = result.articles
                    Thread.printCurrent()
                    DispatchQueue.main.async {
                        Thread.printCurrent()
                        self?.tableView.reloadData()        // reloaded the data received
                    }
                }
            }, onError: {_ in Thread.printCurrent()}, onCompleted: {Thread.printCurrent()}).disposed(by: disposeBag)

    }

}

extension Thread {
    class func printCurrent() {
        print("\r⚡️: \(Thread.current)\r" + "🏭: \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r")
    }
}
