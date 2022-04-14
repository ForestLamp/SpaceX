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

    @IBOutlet weak var firstStartLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var costOfStart: UILabel!
    
    private let networkService = NetworkService()
    private var rockets: [Rocket] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        setupViews()
        fetchData()
    }
    
    func fetchData(){
        networkService.fetchData { (result) in
            switch result {
            case .success(let rockets):
                DispatchQueue.main.async {
                    self.rockets = rockets ?? []
                    self.reloadUI()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func reloadUI(){
        nameOfRocketLabel.text = rockets.first?.name
        firstStartLabel.text = rockets.first?.first_flight
    }
}

// MARK: - Setup layers

extension RocketViewController {
    
    func setupViews(){
        setupLayerForBoundedView()
        setupLabels()
        setupSettingsButton()
        addHorizontalScrollView()
        view.backgroundColor = .black
    }
    
    func setupSettingsButton(){
        settingsButtonOutlet.backgroundColor = .black
        settingsButtonOutlet.tintColor = .white
    }
    
    func setupLabels(){
        nameOfRocketLabel.textColor = .white
        nameOfRocketLabel.font = UIFont(name: "Gothic", size: 30)
        nameOfRocketLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func setupLayerForBoundedView(){
        radialView.layer.masksToBounds = true
        radialView.layer.cornerRadius = radialView.frame.height / 35
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
