//
//  RocketViewController.swift
//  SpaceX
//
//  Created by Alex Ch. on 07.04.2022.
//

import UIKit

class RocketViewController: UIViewController {
    
    @IBOutlet weak var radialView: UIView!
    
    @IBOutlet weak var nameOfRocketLabel: UILabel!
    
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    
    @IBOutlet weak var settingsButtonOutlet: UIButton!
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
}

// MARK: - Setup layers

extension RocketViewController {
    
    func setupViews(){
        setupLayerForBoundedView()
        setupNameOfRocketLabel()
        setupSettingsButton()
        addHorizontalScrollView()
        view.backgroundColor = .black
    }
    
    func setupSettingsButton(){
        settingsButtonOutlet.backgroundColor = .black
        settingsButtonOutlet.tintColor = .white
    }
    
    func setupNameOfRocketLabel(){
        nameOfRocketLabel.textColor = .white
        nameOfRocketLabel.font = UIFont(name: "Gothic", size: 30)
        nameOfRocketLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameOfRocketLabel.text = "Falcon Heavy"
    }
    
    func setupLayerForBoundedView(){
        radialView.layer.masksToBounds = true
        radialView.layer.cornerRadius = radialView.frame.height / 20
        radialView.backgroundColor = .black

    }
}

// MARK: - Horizontall ScrollView

extension RocketViewController{
    
    func addHorizontalScrollView(){
        for _ in 0...3 {
            if let horizontalScrollView = Bundle.main.loadNibNamed("HorizontalParametersScrollView", owner: nil, options: nil)!.first as? HorizontalParameters {
                horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
                horizontalScrollView.layer.cornerRadius = 25
                horizontalScrollView.widthAnchor.constraint(equalToConstant: horizontalStackView.frame.height).isActive = true
                horizontalScrollView.numericLabel.text = "229"
                horizontalScrollView.descriptionLabel.text = "Высота, ft"
                
                horizontalStackView.addArrangedSubview(horizontalScrollView)
            }
        }
    }

}
