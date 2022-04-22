//
//  RocketViewController.swift
//  SpaceX
//
//  Created by Alex Ch. on 07.04.2022.
//

import UIKit

final class RocketViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let networkService = NetworkService()
    private var rockets: [Rocket] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var radialView: UIView!
    @IBOutlet weak var nameOfRocketLabel: UILabel!
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var settingsButtonOutlet: UIButton!
    @IBOutlet weak var firstStartLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var costOfStart: UILabel!
    
    // MARK: - Buttons
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
    }
    
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchData()
    }
    
    // MARK: - Private methods
    
    private func fetchData(){
        networkService.fetchDataForRockets { (result) in
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
    
    private func reloadUI(){
        nameOfRocketLabel.text = rockets.first?.name
        firstStartLabel.text = rockets.first?.first_flight
    }
}

// MARK: - Extensions

extension RocketViewController {
    
    private  func setupViews(){
        setupLayerForBoundedView()
        setupLabels()
        setupSettingsButton()
        addHorizontalScrollView()
        view.backgroundColor = .black
    }
    
    private func setupSettingsButton(){
        settingsButtonOutlet.backgroundColor = .black
        settingsButtonOutlet.tintColor = .white
    }
    
    private func setupLabels(){
        nameOfRocketLabel.textColor = .white
        nameOfRocketLabel.font = UIFont(name: "Gothic", size: 30)
        nameOfRocketLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private  func setupLayerForBoundedView(){
        radialView.layer.masksToBounds = true
        radialView.layer.cornerRadius = radialView.frame.height / 35
        radialView.backgroundColor = .black
    }
}

// MARK: - Horizontall ScrollView

extension RocketViewController{
    
    private func addHorizontalScrollView(){
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
