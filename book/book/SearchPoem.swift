
import UIKit
import CoreData

final class SearchPoem: UIViewController{
  
   //@IBOutlet var tableView: UITableView?
   //@IBOutlet  var searchTextField: UITextField?
    
   
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchTextField: UITextField?
    
    
    private var model: [RatingEntity] = []{
    didSet
    {
        DispatchQueue.main.async {
                [weak self] in self?.tableView?.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getAllModels()
        
        
    }
    private func configure(){
        
        searchTextField?.delegate = self
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(SearchPoemTableView.self,forCellReuseIdentifier:  SearchPoemTableView.cellid)
        
        
        
    }
    
    
    private func getAllModels(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
       // let  fetchRequest = RatingEntity.fetchRequest() // <- Ambiguous use of fetchRequest().
       let fetchRequest: NSFetchRequest<RatingEntity> = RatingEntity.fetchRequest() // <- Works properly.        //
       // let fetchRequest = RatingEntity.fetchRequest()
       // fetchRequest
        
        do {
            model = try managedContext.fetch(fetchRequest)
        } catch
         {
            print("here", error.localizedDescription)
        }
    }
}
extension SearchPoem : UITextFieldDelegate {
    
}


extension SearchPoem: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPoemTableView.cellid, for: indexPath) as? SearchPoemTableView else {
            return UITableViewCell()}
        
        let cellModel =  model[indexPath.row]
        cell.setUp(RatingEntity: cellModel)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
}
