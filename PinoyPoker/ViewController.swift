import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var textField: UITextField!
    var gameroomid: Int = 1141 // Declare the gameroomid property


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
    
    
    var textField1: UITextField!
    var storeButton: UIButton!

    // Variable to store the text
    var storedText: String = ""

    override func viewDidLoad() {
            super.viewDidLoad()
        

        // Create and configure the button
        
        displayLabelWithCompletion()
        let backgroundImage = UIImageView(image: UIImage(named: "BackgroundImage")) // Change "BackgroundImage" to the actual name of your background image
           backgroundImage.frame = view.bounds
           backgroundImage.contentMode = .scaleAspectFill
           view.insertSubview(backgroundImage, at: 0)

        setupUI()

        }
    

    func setupUI() {
        
        textField = UITextField(frame: CGRect(x: 0, y: -200, width: view.center.x , height: 30))
        textField.delegate = self // Set the delegate
        textField.text = "\(GameID)"
        

        let createGameButton = UIButton(type: .system)
        createGameButton.setTitle("New Game", for: .normal)
        createGameButton.setTitleColor(.white, for: .normal) // Set text color to white
        createGameButton.backgroundColor = .black // Set background color to black
        createGameButton.addTarget(self, action: #selector(createGameButtonTapped), for: .touchUpInside)
        createGameButton.frame = CGRect(x: 0, y: 0, width: view.center.x, height: 50)
        createGameButton.center = CGPoint(x: view.center.x, y: view.center.y * 0.4)
        createGameButton.layer.cornerRadius = 5.0
        createGameButton.clipsToBounds = true
        view.addSubview(createGameButton)


            let joinGameButton = UIButton(type: .system)
            joinGameButton.setTitle("Join Game", for: .normal)
            joinGameButton.addTarget(self, action: #selector(joinGameButtonTapped), for: .touchUpInside)
            joinGameButton.frame = CGRect(x: 0, y: 0, width: view.center.x , height: 50)
        joinGameButton.center = CGPoint(x: view.center.x, y: view.center.y * 0.525)
            joinGameButton.setTitleColor(.white, for: .normal) // Set text color to white
            joinGameButton.backgroundColor = .black // Set background color to black
            joinGameButton.layer.cornerRadius = 5.0

        
            view.addSubview(joinGameButton)
        
        textField1 = UITextField(frame: CGRect(x: view.center.x * 0.5, y: view.center.y * 0.6, width: view.center.x, height: 50))
        textField1.placeholder = "ENTER ROOM ID"// Set the delegate
        textField1.borderStyle = .roundedRect
        //textField1.text = "\(GameID)"
        view.addSubview(textField1)
        
    }

    @objc func createGameButtonTapped() {
        // Handle create game button tap
        removePreviousCards()
        let backgroundImage = UIImageView(image: UIImage(named: "BackgroundImage")) // Change "BackgroundImage" to the actual name of your background image
           backgroundImage.frame = view.bounds
           backgroundImage.contentMode = .scaleAspectFill
           view.insertSubview(backgroundImage, at: 0)

        createRoomAndLoadUI { [weak self] in
            self?.displayLabelWithCompletion()
        }
    }

    @objc func joinGameButtonTapped() {
        // Hide the keyboard
        textField1.resignFirstResponder()

        // Check if the textField1 is empty
        guard let inputText = textField1.text, !inputText.isEmpty else {
            // Show an alert with an error message
            let alert = UIAlertController(title: "Error", message: "Please provide a room ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Store the text in the variable
        storedText = inputText

        // Print the stored text to the console
        print("Stored Text: \(storedText)")

        removePreviousCards()
        let backgroundImage = UIImageView(image: UIImage(named: "BackgroundImage")) // Change "BackgroundImage" to the actual name of your background image
        backgroundImage.frame = view.bounds
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)

        joinRoomAndLoadUI { [weak self] in
            self?.displayLabelWithCompletion()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField1.resignFirstResponder() // Hide the keyboard
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) // Hide the keyboard
    }

    func removePreviousCards() {
        for subview in view.subviews {
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
    }
    // Implement UITextFieldDelegate method for handling text changes
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // Calculate the new text after applying the replacement
//        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
//        // Update the text field's text with the new text
//        textField.text = newText
//        return false // Return false to allow the changes
//    }
//
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // Construct the updated text after the replacement
//        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
//        
//        // Try to convert the updated text to an integer
//        if let newGameroomid = Int(newText ?? "") {
//            gameroomid = newGameroomid // Update the gameroomid variable
//        }
//        
//        return true
//    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let gameroomidText = textField.text,
           let newGameroomid = Int(gameroomidText) {
            gameroomid = newGameroomid // Update the gameroomid variable
        }
    }

    func displayLabelWithCompletion() {
        let textField = UILabel(frame: CGRect(x: 0, y: -200, width: 200, height: 30))
//        textField.delegate = self // Set the delegate
        textField.text = "Room ID: \(GameID)"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = .black
//        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        textField.clipsToBounds = true
        let xOffsetPercentage: CGFloat = 0 // 10% of the screen's width
        let yOffsetPercentage: CGFloat = 0.4 // 40% of the screen's height

        let xOffset = view.bounds.width * xOffsetPercentage
        let yOffset = view.bounds.height * yOffsetPercentage

        textField.center = CGPoint(x: view.center.x + xOffset, y: view.center.y - yOffset);
        view.addSubview(textField)
    }

    
    





//        @objc func joinGameButtonTapped() {
//            // Handle join game button tap
//            // Implement your logic for joining a game here
//        }

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
    func joinRoomAndLoadUI(completion: @escaping () -> Void) {
        guard textField != nil else {
            print("TextField is not initialized")
            return
        }
        joinRoom { [weak self] player1hand, gameroomid in
            self?.P1Hand = player1hand
            self?.GameID = gameroomid
            DispatchQueue.main.async {
                self?.loadUI()
                completion() // Call the completion handler here
            }
        }
    }

    
    var spotViews: [UIView] = []
    
    
    func loadUI() {
        let cardWidth: CGFloat = view.bounds.width * 0.13
        let cardHeight: CGFloat = cardWidth * 1.5
        let overlap: CGFloat = 25 // Adjust the overlap between cards

        let totalSpots = 13
        let totalRows = [3, 5, 5]
        let spotWidth: CGFloat = view.bounds.width * 0.13

        // Calculate the starting X position to center the spots
        let startX = (view.bounds.width - CGFloat(totalRows[0]) * spotWidth - CGFloat(totalRows[0] - 1) * overlap) / 2

        var currentX: CGFloat = startX
        var currentY: CGFloat = 20 // Adjust the initial Y position as needed
        var currentRow = 0 // Track the current row

        // Create spots for cards and add them to the array
        for _ in 0..<totalSpots {
            let spotView = UIView()
            spotView.frame = CGRect(x: currentX-80, y: currentY+400, width: spotWidth, height: cardHeight)
            spotView.layer.borderWidth = 2.0
            spotView.layer.borderColor = UIColor.darkGray.cgColor
            view.addSubview(spotView)
            spotViews.append(spotView) // Add the spotView to the class-level array

            currentX += spotWidth + overlap

            if currentRow < totalRows.count - 1 && (currentX + cardWidth) > (startX + CGFloat(totalRows[currentRow]) * spotWidth + CGFloat(totalRows[currentRow]) * overlap) {
                // Move to the next row
                currentRow += 1
                currentX = startX
                currentY += cardHeight + 10 // Adjust the vertical spacing between rows as needed
            }
        }
        
//        print("Number of spotViews: \(spotViews.count)") // Debugging statement
//        print(spotViews)


        // Your existing code for displaying cards at the bottom
        let totalCards = P1Hand.count
        let totalWidth = CGFloat(totalCards) * (cardWidth - overlap) + overlap
        let cardsStartX = (view.bounds.width - totalWidth) / 2
        var cardsCurrentX: CGFloat = cardsStartX
        let cardsStartY: CGFloat = view.bounds.height - cardHeight - 20
        var elevationOffset: CGFloat = 0

        for (index, cardId) in P1Hand.enumerated() {
            if let cardData = cards.first(where: { ($0["id"] as? Int) == cardId }),
               let name = cardData["name"] as? String {
                let imageName = "\(name).png"
                if let image = UIImage(named: imageName) {
                    let imageView = UIImageView(image: image)
                    imageView.frame = CGRect(x: cardsCurrentX, y: cardsStartY - elevationOffset, width: cardWidth, height: cardHeight)
                    imageView.backgroundColor = UIColor.white
                    imageView.layer.borderWidth = 2.0
                    imageView.layer.borderColor = UIColor.black.cgColor
                    imageView.layer.cornerRadius = 5.0
                    imageView.clipsToBounds = true
                    view.addSubview(imageView)

                    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                    imageView.addGestureRecognizer(panGesture)
                    imageView.isUserInteractionEnabled = true

                    if index % 2 == 1 {
                        elevationOffset = 0
                    } else {
                        elevationOffset += 20
                    }

                    cardsCurrentX += cardWidth - overlap
                }
            }
        }
    }

    



//    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
//        guard let cardImageView = gesture.view else { return }
//
//        if gesture.state == .began || gesture.state == .changed {
//            let translation = gesture.translation(in: view)
//            cardImageView.center = CGPoint(x: cardImageView.center.x + translation.x, y: cardImageView.center.y + translation.y)
//            gesture.setTranslation(CGPoint.zero, in: view)
//        }
//    }

    
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let cardImageView = gesture.view as? UIImageView else { return }
        if gesture.state == .began || gesture.state == .changed {
            let translation = gesture.translation(in: view)
            cardImageView.center = CGPoint(x: cardImageView.center.x + translation.x, y: cardImageView.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: view)
        }

        if gesture.state == .ended {
//            print(spotViews)

            // Find the nearest spotView
            print(cardImageView.center)
            var nearestSpotView: UIView?

            for spotView in spotViews {
                if cardImageView.frame.intersects(spotView.frame) {
                    nearestSpotView = spotView
                    break
                }
            }

            // Animate the card to snap into the nearest spotView
            UIView.animate(withDuration: 0.3) {
                if let snapToSpotView = nearestSpotView {
                    cardImageView.center = snapToSpotView.center
                }
//                else {
//                    // If no spotView is nearby, return the card to its original position
//                    cardImageView.frame = CGRect(x: cardsCurrentX, y: cardsStartY - elevationOffset, width: cardWidth, height: cardHeight)
//                }
            }
        }
    }



    func createRoom(completion: @escaping ([Int], Int) -> Void) {
            guard let url = URL(string: "https://swiftcardgameserver-5enxm.ondigitalocean.app/api/create-room")
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
    func joinRoom(completion: @escaping ([Int], Int) -> Void) {
//        let gameroomid = self.gameroomid // Use the updated value
        guard let gameroomidText = textField.text,
                  let gameroomid = Int(gameroomidText),
                  let url = URL(string: "https://swiftcardgameserver-5enxm.ondigitalocean.app/api/join-room?gameroomid=\(storedText)")
                    
            else {
                return
            }
        print(gameroomid)
        print(url)



            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 404{
                        DispatchQueue.main.async {
                            // Show an alert indicating that the room does not exist
                            let alert = UIAlertController(title: "Error", message: "Room does not exist", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                
                //print("\(data)")
                
                if let data = data {
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                           let jsonData = jsonArray.first,
                           let gameroomid = jsonData["gameroomid"] as? Int {
                            
                            var player1hand: [Int] = []
                            if let player2handArray = jsonData["player2hand"] as? [Int] {
                                player1hand = player2handArray
                            }
                            
                            var player3hand: [Int] = []
                            if let player3handArray = jsonData["player3hand"] as? [Int] {
                                player3hand = player3handArray
                            }
                            
                            var player4hand: [Int] = []
                            if let player4handArray = jsonData["player4hand"] as? [Int] {
                                player4hand = player4handArray
                            }
                            
                            print("player2: \(player1hand)")
                            print("player3: \(player3hand)")
                            print("player4: \(player4hand)")
                            print("Game Room ID: \(gameroomid)")
                            
                            if player1hand == [] {
                                player1hand = player3hand
                                if player3hand == [] {
                                    player1hand = player4hand
                                }
                            }
                            
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
