//
//  ViewController.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 03/05/19.
//  Copyright © 2019 Bhavesh Chaudhari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var feedsTabelView : UITableView!
    
    var modelController : PaggedArray<NewsFeed>?
    fileprivate let imageLoadQueue = OperationQueue()
    fileprivate var imageLoadOperations = [IndexPath: ImageLoadOperation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPost()
        // Do any additional setup after loading the view.
    }


    func fetchPost(compltion : (()->())? = nil) {
        modelController = PaggedArray<NewsFeed>(parameter:["pageSize":20])
        modelController!.retrieveComment { [weak self] (result) in
            if result {
                self?.feedsTabelView.reloadData()
                if compltion != nil {
                    compltion!()
                }
            }
        }
    }
}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (modelController == nil) ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController?.viewModelsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"NewsFeedTableViewCell", for: indexPath) as! NewsFeedTableViewCell
        if let selectedFedds = modelController?.viewModel(at: indexPath.row) {
            cell.configureCell(model: selectedFedds)
            if let imageLoadOperation = imageLoadOperations[indexPath],
                let image = imageLoadOperation.image {
                cell.feedsImage.image = image
            } else {
                if   let postImageString = selectedFedds.photos?.compressedImgURL , postImageString != "" , let _ = URL(string:postImageString) {
                    
                    let imageLoadOperation = ImageLoadOperation(url: postImageString)
                    imageLoadOperation.completionHandler = { [weak self] (image) in
                        cell.feedsImage.image = image
                        self?.imageLoadOperations.removeValue(forKey: indexPath)
                    }
                    imageLoadQueue.addOperation(imageLoadOperation)
                    imageLoadOperations[indexPath] = imageLoadOperation
                }
            }
        }

        return cell
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}


extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            //
            if let _ = imageLoadOperations[indexPath] {
                return
            }

            if let viewModel = modelController!.viewModel(at: (indexPath as NSIndexPath).row) ,  let postImageString = viewModel.photos?.compressedImgURL , postImageString != "" , let _ = URL(string:postImageString) {
                let imageLoadOperation = ImageLoadOperation(url: postImageString)
                imageLoadQueue.addOperation(imageLoadOperation)
                imageLoadOperations[indexPath] = imageLoadOperation
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let imageLoadOperation = imageLoadOperations[indexPath] else {
                return
            }
            imageLoadOperation.cancel()
            imageLoadOperations.removeValue(forKey: indexPath)
        }
    }
}




