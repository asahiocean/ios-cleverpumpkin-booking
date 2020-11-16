import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URLs.get else { return }
        let task = URLSession.shared.dataTask(with: url) { hotel, response, error in
            if let jsonData = hotel {
                do {
                    let hotels = try newJSONDecoder().decode([Hotel].self, from: jsonData)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
