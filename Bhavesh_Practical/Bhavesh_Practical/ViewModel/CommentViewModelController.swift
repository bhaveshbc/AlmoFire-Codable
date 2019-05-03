//
//  CommentViewModelController.swift

import Foundation
import UIKit


typealias RetrieveUsersCompletionBlock = (_ success: Bool) -> Void

class PaggedArray<T:Codable> {
    private  var pageSize = 0
    
    var viewModels: [T] = []
    private var currentPage = 0
    private var lastPage = -1
    private var retrieveUsersCompletionBlock: RetrieveUsersCompletionBlock?
    var apirouter : APIRouter!
    var parameter : [String:Any]
    
   
    init(parameter:[String:Any]) {
        self.parameter = parameter
        pageSize = parameter["pageSize"] as! Int
    }
    
    func retrieveComment(_ completionBlock: @escaping RetrieveUsersCompletionBlock) {
        retrieveUsersCompletionBlock = completionBlock
        loadNextPageIfNeeded(for: 0)
    }
    
    var viewModelsCount: Int {
        return viewModels.count
    }
    
    func updateModel(at index : Int , with:T) {
        if viewModels.indices.contains(index) {
            viewModels[index] = with
        }
    }
    
    func deleteIteam(at index:Int) {
        if viewModels.indices.contains(index) {
            viewModels.remove(at: index)
        }
    }
    
    func deleteAll() {
        lastPage = -1
        currentPage = 0
        viewModels.removeAll()
    }
    
    func viewModel(at index: Int) -> T? {
        guard index >= 0 && index < viewModelsCount else { return nil }
        loadNextPageIfNeeded(for: index)
        return viewModels[index]
    }
}

private extension PaggedArray {
    
    func loadNextPageIfNeeded(for index: Int) {
//        print("index =\(index)")
        let targetCount = currentPage < 1 ? 0 : (currentPage) * pageSize - 4
//        print("targetCount =\(targetCount)")
        guard index == targetCount else {
            return
        }
        currentPage += 1
        if currentPage != 1 {
            (UIApplication.shared.delegate as! AppDelegate).displayLoader = false
        }
        
        parameter["page"] = currentPage
        
        apirouter = APIRouter.NwesFeed(usermodel: parameter)
        
        
        
        BaseApiClient.default.fetch(request: self.apirouter) {  (response:ResponseBaseArray<T>?) in
            if let data = response?.data {
                self.viewModels.append(contentsOf: data)
                self.retrieveUsersCompletionBlock!(true)
            }
        }
    }
}
