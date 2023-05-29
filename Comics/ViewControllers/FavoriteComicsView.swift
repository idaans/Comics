//
//  FavoriteComicsView.swift
//  Comics
//
//  Created by Ida Anseth  on 21/05/2023.
//

import Foundation
import UIKit

class FavoriteComicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var favoriteComicsManager = FavoriteComicsManager()
    var favoritesList:[FavoriteComicsList]?
    var object: ComicsModel?
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        
        title = "Favorite Comics"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        getFavoritesList()
    }
    
    func getFavoritesList(){
        do {
            self.favoritesList = try context.fetch(FavoriteComicsList.fetchRequest())
            print("Fetching all favorites")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("\(self.favoritesList?.description)")
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = self.favoritesList![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ("\(object?.title) \(object?.num)")
        //fetch image
        return cell
    }
}
