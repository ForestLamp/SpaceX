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
    
    
    
    // __________________________________
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
// Это ужасно, надо незабыть переделать!!!
        let urlString = "https://api.spacexdata.com/v4/rockets"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            if let error = error {
                print("Ошибка запроса \(error)")
            }
            guard let data = data else {return}
            do {
                let rokets = try JSONDecoder().decode([Rocket].self, from: data)
                print(rokets)
                DispatchQueue.main.async {
                    let rocketName = rokets.first
                    self.nameOfRocketLabel.text = rocketName?.name
                }
                
            }
            catch {
                print(error)
            }
        }.resume()
        
// Вот до сюда это точно ужасно!!!!!
        
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
