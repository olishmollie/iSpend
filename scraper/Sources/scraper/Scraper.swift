import Foundation

class Scraper {
    var request: URLRequest
    
    init?(url: String) {
        
        if let url = URL(string: url) {
            self.request = URLRequest(url: url)
            self.request.httpMethod = "get"
        } else {
            return nil
        }
    }
    
    func sendRequest() {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { print(String(describing: error)); return; }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Error: http response code is: \(response.statusCode)")
                return
            }
            let html = String(describing: data)
            print(html)
        }
        task.resume()
    }

}
