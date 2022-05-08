import UIKit

struct NewsModel : Decodable{
    var array : [Array] = []
    //var poet : [poet] = []
}


struct Array : Decodable{
    let title : String
    let content : String
   // let url :String
    
}
struct poet {
    let name: String
    let poet_url :String
    
}


class ViewController: UIViewController {
    private var model = NewsModel()
   
    
   
    @IBOutlet var tabelView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requestPoems()
    }
    
private func requestPoems(){
        let pathString = "https://www.poemist.com/api/v1/randompoems"
        let url = URL(string: pathString)!
    
        let task = URLSession.shared.dataTask(with: url){
                data, _, error in
                if let _ = error {
                    print("here::")
                    return
                }
            
             
             guard let data = data else {
                return
                
            }
           
            let array: [Array] = try! JSONDecoder().decode([Array].self, from: data)
            print(array)
            self.model.array = array
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
            
           
        }
      
        task.resume()
        
    }
    

  private func configure()
    {
        title = "Bazzar"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.register(News.self, forCellReuseIdentifier: News.cellid)
    }
    private func navigate(array: Array){
        guard let viewController = storyboard?.instantiateViewController(identifier: "ArticleController") as? ArticleController
            else {
            return
                
        }
        viewController.array = array
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: News.cellid, for: indexPath)
            as? News else {
                return UITableViewCell()
                
        }
        let cellModel = model.array[indexPath.row]
        cell.setUp(with:cellModel)
        return cell
    }
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.array.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let array = model.array[indexPath.row]
        navigate(array:array)
    }
    
}
