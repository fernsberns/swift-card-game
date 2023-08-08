import UIKit

class ViewController: UIViewController {

    let cards: [[String: Any]] = [
            ["id": 1, "name": "cardDiamonds_A"],
            ["id": 2, "name": "cardDiamonds_2"],
            ["id": 3, "name": "cardDiamonds_3"],
            ["id": 4, "name": "cardDiamonds_4"],
            ["id": 5, "name": "cardDiamonds_5"],
            ["id": 6, "name": "cardDiamonds_6"],
            ["id": 7, "name": "cardDiamonds_7"],
            ["id": 8, "name": "cardDiamonds_8"],
            ["id": 9, "name": "cardDiamonds_9"],
            ["id": 10, "name": "cardDiamonds_10"],
            ["id": 11, "name": "cardDiamonds_J"],
            ["id": 12, "name": "cardDiamonds_Q"],
            ["id": 13, "name": "cardDiamonds_K"],
            
            ["id": 14, "name": "cardHearts_A"],
            ["id": 15, "name": "cardHearts_2"],
            ["id": 16, "name": "cardHearts_3"],
            ["id": 17, "name": "cardHearts_4"],
            ["id": 18, "name": "cardHearts_5"],
            ["id": 19, "name": "cardHearts_6"],
            ["id": 20, "name": "cardHearts_7"],
            ["id": 21, "name": "cardHearts_8"],
            ["id": 22, "name": "cardHearts_9"],
            ["id": 23, "name": "cardHearts_10"],
            ["id": 24, "name": "cardHearts_J"],
            ["id": 25, "name": "cardHearts_Q"],
            ["id": 26, "name": "cardHearts_K"],
            
            ["id": 27, "name": "cardClubs_A"],
            ["id": 28, "name": "cardClubs_2"],
            ["id": 29, "name": "cardClubs_3"],
            ["id": 30, "name": "cardClubs_4"],
            ["id": 31, "name": "cardClubs_5"],
            ["id": 32, "name": "cardClubs_6"],
            ["id": 33, "name": "cardClubs_7"],
            ["id": 34, "name": "cardClubs_8"],
            ["id": 35, "name": "cardClubs_9"],
            ["id": 36, "name": "cardClubs_10"],
            ["id": 37, "name": "cardClubs_J"],
            ["id": 38, "name": "cardClubs_Q"],
            ["id": 39, "name": "cardClubs_K"],
            
            ["id": 40, "name": "cardSpades_A"],
            ["id": 41, "name": "cardSpades_2"],
            ["id": 42, "name": "cardSpades_3"],
            ["id": 43, "name": "cardSpades_4"],
            ["id": 44, "name": "cardSpades_5"],
            ["id": 45, "name": "cardSpades_6"],
            ["id": 46, "name": "cardSpades_7"],
            ["id": 47, "name": "cardSpades_8"],
            ["id": 48, "name": "cardSpades_9"],
            ["id": 49, "name": "cardSpades_10"],
            ["id": 50, "name": "cardSpades_J"],
            ["id": 51, "name": "cardSpades_Q"],
            ["id": 52, "name": "cardSpades_K"]
        ]

    var P1Hand: [Int] = [37, 9, 11, 38, 27, 6, 13, 46, 5, 33, 48, 50, 39]
    override func viewDidLoad() {
            super.viewDidLoad()

            createRoomAndLoadUI()
        }

        func createRoomAndLoadUI() {
            createRoom { [weak self] player1hand in
                self?.P1Hand = player1hand
                DispatchQueue.main.async {
                    self?.loadUI()
                }
            }
        }

        func loadUI() {
            let cardWidth: CGFloat = 10
            let cardHeight: CGFloat = 15
            let spacing: CGFloat = 2
            let startX: CGFloat = (view.bounds.width - (cardWidth * 4 + spacing * 3)) / 2
            let startY: CGFloat = (view.bounds.height - cardHeight) / 2

            for cardId in P1Hand {
                if let cardData = cards.first(where: { ($0["id"] as? Int) == cardId }),
                   let name = cardData["name"] as? String {
                    let imageName = "\(name).png"
                    if let image = UIImage(named: imageName),
                       let cardIndex = P1Hand.firstIndex(of: cardId) {
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: startX + CGFloat(cardIndex % 13) * (cardWidth + spacing),
                                                 y: startY,
                                                 width: cardWidth,
                                                 height: cardHeight)
                        view.addSubview(imageView)
                    }
                }
            }
        }

        func createRoom(completion: @escaping ([Int]) -> Void) {
            guard let url = URL(string: "http://192.168.0.8:3000/api/create-room") else {
                return
            }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }

                if let data = data {
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                           let jsonData = jsonArray.first,
                           let player1hand = jsonData["player1hand"] as? [Int] {
                            print(player1hand)
                            completion(player1hand)
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                        let responseString = String(data: data, encoding: .utf8)
                        print("Response Data: \(responseString ?? "")")
                    }
                }
            }.resume()
        }
    }
