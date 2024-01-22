//
//  WeatherForecastView.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 17.01.2024.
//

import Foundation
import UIKit

protocol WeatherDetailDelegate: AnyObject {
    func showWeatherDetail(forDay: String)
}
 
class WeatherForecastView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherForecastItemCell.self, forCellWithReuseIdentifier: Constants.shared.WeatherForecastItemCell)
        return collectionView
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 0
        button.tintColor = .black
        button.setImage(UIImage(systemName: "lessthan.circle.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)),
                                for: .normal)
        button.addTarget(self, action: #selector(directionButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 1
        button.tintColor = .black
        button.setImage(UIImage(systemName: "greaterthan.circle.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)),
                                for: .normal)
        button.addTarget(self, action: #selector(directionButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var progressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(style: .large)
        progressView.startAnimating()
        progressView.color = .black
        progressView.layer.cornerRadius = 10
        progressView.backgroundColor = .clear
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private lazy var flowLayout = UICollectionViewFlowLayout()
    weak var delegate: WeatherDetailDelegate? = nil
    lazy var weatherData: [WeatherForecast]? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    func initialize() {
        setupCollectionView()
        createProgressView()
        createDirectionButtons()
    }
    
    func setupCollectionView() {
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    func createProgressView() {
        self.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalTo: self.widthAnchor),
            progressView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    func createDirectionButtons() {
        self.addSubview(previousButton)
        NSLayoutConstraint.activate([
            previousButton.widthAnchor.constraint(equalToConstant: 100),
            previousButton.heightAnchor.constraint(equalToConstant: 100),
            previousButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            previousButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 100),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            nextButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc func directionButtonTapped(_ sender: UIButton) {
        // Feedback
        UIImpactFeedbackGenerator().impactOccurred()
        
        // Button action configure
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: NSIndexPath = visibleItems.object(at: 0) as! NSIndexPath
        
        if sender.tag != 0 {
            let nextItem: NSIndexPath = NSIndexPath(row: currentItem.item + 1, section: 0)

            if nextItem.item == weatherData?.count {
                return
            }

            self.collectionView.scrollToItem(at: nextItem as IndexPath, at: .left, animated: true)
        } else {
            let nextItem: NSIndexPath = NSIndexPath(row: currentItem.item - 1, section: 0)
            
            if nextItem.item < 0 {
                return
            }
           
            self.collectionView.scrollToItem(at: nextItem as IndexPath, at: .right, animated: true)
        }
    }
    
    func updateWeathersDetail(data: [WeatherForecast]?) {
        self.weatherData = data
        self.collectionView.reloadData()
        self.progressView.stopAnimating()
        self.progressView.isHidden = true
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeatherForecastView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = self.weatherData?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let contentCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.shared.WeatherForecastItemCell,
            for: indexPath) as? WeatherForecastItemCell else {
            return UICollectionViewCell()
        }
        
        if let weatherData = self.weatherData?[indexPath.row] {
            contentCell.bindCell(data: weatherData)
        }
        
        return contentCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let weatherData = self.weatherData?[indexPath.row].dtTxt {
            delegate?.showWeatherDetail(forDay: weatherData)
        }
    }
}
