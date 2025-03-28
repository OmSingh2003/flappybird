//
// FlappyBird Clone
// Created by Om Singh
// Copyright © 2025 Om Singh. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var launchView: UIView! // View for the launch screen overlay

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLaunchScreen()

        // Add tap gesture to start game
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(startGame))
        launchView.addGestureRecognizer(tapGesture)
    }

    // Sets up the launch screen as an overlay
    func setupLaunchScreen() {
        launchView = UIView(frame: view.bounds)
        launchView.backgroundColor = UIColor.black

        // Add background image
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "background") // Ensure this image exists in Assets
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        launchView.addSubview(backgroundImage)

        // Add start label
        let startLabel = UILabel()
        startLabel.text = "Touch the screen to start the game"
        startLabel.textAlignment = .center
        startLabel.textColor = UIColor(red: 0.36, green: 0.42, blue: 0.44, alpha: 1) // Match the storyboard color
        startLabel.font = UIFont.systemFont(ofSize: 17, weight: .black) // Match font & size
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        launchView.addSubview(startLabel)

        view.addSubview(launchView) // Overlay launch screen

        // Apply Auto Layout constraints
        NSLayoutConstraint.activate([
            // Background Image Constraints
            backgroundImage.topAnchor.constraint(equalTo: launchView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: launchView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: launchView.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: launchView.bottomAnchor),
            
            // Label Constraints (Positioned Exactly as in LaunchScreen.storyboard)
            startLabel.centerXAnchor.constraint(equalTo: launchView.centerXAnchor),
            startLabel.bottomAnchor.constraint(equalTo: launchView.bottomAnchor, constant: -280) // Adjust this value if needed
        ])
    }


    // Starts the game after tap
    @objc func startGame() {
        UIView.animate(withDuration: 0.5, animations: {
            self.launchView.alpha = 0
        }) { _ in
            self.launchView.removeFromSuperview()
            
            if let skView = self.view as? SKView {
                let scene = GameScene(size: skView.bounds.size)
                scene.scaleMode = .aspectFill
                skView.presentScene(scene)
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .phone ? .allButUpsideDown : .all
    }
}
