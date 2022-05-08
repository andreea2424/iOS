import UIKit
import WebKit
import CoreData

class ArticleController: UIViewController {
    
 
    //@IBOutlet var viewconfskag: UIView!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBOutlet weak var star6: UIButton!
    
    @IBOutlet weak var RatingView: UILabel!
    
    var rating: Int = 0
   
    @IBOutlet weak var ArticleView: UITextView!
    
    
    var array : Array?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        
    }
    private func configure(){
        guard let array  = array else {
            return
        }
        
        ArticleView.text = array.content
        title = array.title
        
        configureStars()
        //RatingTextField.delegate = self
        
       // RatingTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    private func configureStars() {
        star1.tag = 2
        star2.tag = 1
        star3.tag = 3
        star4.tag = 4
        star5.tag = 6
        star6.tag = 5
        
    }
    
    
    
    
    @IBAction func didRateArticle(_ sender: UIButton) {
        rating = sender.tag
        addRating()
    }
    
    
    private func addRating(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName:"RatingEntity", in : managedContext), let item = array else {return}
        let ratingEntity = RatingEntity(entity:entity, insertInto: managedContext )
        ratingEntity.rating = Int64(rating)
        ratingEntity.name = item.title
        ratingEntity.content = item.content
        
        
        //commit la schimbari
        
        do {
            try managedContext.save()
            print("here::Saved", rating)
        }
        catch{
            print("here::", error.localizedDescription)
        }
    
    }
}


