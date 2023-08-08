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
    var GameID: Int = 0

    override func viewDidLoad() {
            super.viewDidLoad()
        setupUI()

        }
    
    
    
    func setupUI() {
            let createGameButton = UIButton(type: .system)
            createGameButton.setTitle("Deal Cards", for: .normal)
            createGameButton.addTarget(self, action: #selector(createGameButtonTapped), for: .touchUpInside)
            createGameButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
            createGameButton.center = CGPoint(x: view.center.x - 100, y: view.center.y - 200)
            view.addSubview(createGameButton)
        


            let joinGameButton = UIButton(type: .system)
            joinGameButton.setTitle("Join Game", for: .normal)
            joinGameButton.addTarget(self, action: #selector(joinGameButtonTapped), for: .touchUpInside)
            joinGameButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
            joinGameButton.center = CGPoint(x: view.center.x - 100, y: view.center.y - 150)
            view.addSubview(joinGameButton)
        }

    @objc func createGameButtonTapped() {
        // Handle create game button tap
        removePreviousCards()
        createRoomAndLoadUI { [weak self] in
            self?.displayLabelWithCompletion()
        }
    }

    func removePreviousCards() {
        for subview in view.subviews {
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
    }

    func displayLabelWithCompletion() {
        let label = UILabel(frame: CGRect(x: 0, y: -200, width: 200, height: 30))
        label.text = "Room: \(GameID)"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 5.0
        label.clipsToBounds = true
        let xOffsetPercentage: CGFloat = 0 // 10% of the screen's width
        let yOffsetPercentage: CGFloat = 0.4 // 40% of the screen's height

        let xOffset = view.bounds.width * xOffsetPercentage
        let yOffset = view.bounds.height * yOffsetPercentage

        label.center = CGPoint(x: view.center.x + xOffset, y: view.center.y - yOffset);        view.addSubview(label)
    }

    
    





        @objc func joinGameButtonTapped() {
            // Handle join game button tap
            // Implement your logic for joining a game here
        }

    func createRoomAndLoadUI(completion: @escaping () -> Void) {
        createRoom { [weak self] player1hand, gameroomid in
            self?.P1Hand = player1hand
            self?.GameID = gameroomid
            DispatchQueue.main.async {
                self?.loadUI()
                completion() // Call the completion handler here
            }
        }
    }


    func loadUI() {
        let cardWidth: CGFloat = 40
        let cardHeight: CGFloat = 60
        let spacing: CGFloat = 15
        let margin: CGFloat = 0 // Adjust this value for the desired margin
        let startX: CGFloat = (view.bounds.width - (cardWidth * 5 + spacing * 4)) / 2
        let startYTop: CGFloat = (view.bounds.height - cardHeight * 2 - spacing * 2) / 2
        let startYMiddle: CGFloat = startYTop + cardHeight * 1.5 + spacing
        let startYBottom: CGFloat = startYMiddle + cardHeight * 1.5 + spacing * 2

        var currentX: CGFloat = startX
        var currentY: CGFloat = startYTop

        var cardsCount = 0

        for cardId in P1Hand {
            if let cardData = cards.first(where: { ($0["id"] as? Int) == cardId }),
               let name = cardData["name"] as? String {
                let imageName = "\(name).png"
                if let image = UIImage(named: imageName) {
                    let imageView = UIImageView(image: image)
                    imageView.frame = CGRect(x: currentX + margin, y: currentY + margin, width: cardWidth - 2 * margin, height: cardHeight - 2 * margin)
                    imageView.layer.borderWidth = 2.0 // Add a border
                    imageView.layer.borderColor = UIColor.black.cgColor
                    imageView.layer.cornerRadius = 5.0
                    imageView.clipsToBounds = true
                    view.addSubview(imageView)

                    // Add pan gesture recognizer for draggable behavior
                    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                    imageView.addGestureRecognizer(panGesture)
                    imageView.isUserInteractionEnabled = true

                    cardsCount += 1
                    if cardsCount == 3 {
                        currentX = startX
                        currentY = startYMiddle
                    } else if cardsCount == 8 {
                        currentX = startX
                        currentY = startYBottom
                    } else {
                        currentX += cardWidth + spacing
                    }
                }
            }
        }
    }

    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let cardImageView = gesture.view else { return }
        
        if gesture.state == .began || gesture.state == .changed {
            let translation = gesture.translation(in: view)
            cardImageView.center = CGPoint(x: cardImageView.center.x + translation.x, y: cardImageView.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: view)
        }
    }


    func createRoom(completion: @escaping ([Int], Int) -> Void) {
            guard let url = URL(string: "http://192.168.0.8:3000/api/create-room")
            else {
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
                           let gameroomid = jsonData["gameroomid"] as? Int,
                           let player1hand = jsonData["player1hand"] as? [Int] {
                            print(player1hand)
                            print("Game Room ID: \(gameroomid)")

                            completion(player1hand, gameroomid)
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
