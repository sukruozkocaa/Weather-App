//
//  WeatherNowView.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 17.01.2024.
//

import Foundation
import UIKit
import Kingfisher

class WeatherNowView: UIView {
    
    //  Views
    private lazy var pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.image = UIImage(named: "mapPin")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .right
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "wind", withConfiguration: UIImage.SymbolConfiguration(pointSize: 1))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.textColor = UIColor.black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var iconProgressView: UIActivityIndicatorView = {
        let progressView = UIActivityIndicatorView(style: .medium)
        progressView.startAnimating()
        progressView.color = .black
        progressView.layer.cornerRadius = 10
        progressView.backgroundColor = .red.withAlphaComponent(0.3)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    // Variables
    private var weatherTemp: Double? = 0.0
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    // Initialize
    private func initialize() {
        updateViewLayers()
        createPinImageView()
        createLocationLabel()
        createCurrentTempLabel()
        createCurrentWeatherImageView()
        createCurrentWeatherStatusLabel()
        createCurrentWindItems()
        createProgressView()
        createImageProgressView()
    }
    
    // Update View Layers
    private func updateViewLayers() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    // Pin Image
    private func createPinImageView() {
        self.addSubview(pinImageView)
        NSLayoutConstraint.activate([
            pinImageView.widthAnchor.constraint(equalToConstant: 20),
            pinImageView.heightAnchor.constraint(equalToConstant: 20),
            pinImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            pinImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    // Current Location
    private func createLocationLabel() {
        self.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: pinImageView.trailingAnchor, constant: 10),
            locationLabel.centerYAnchor.constraint(equalTo: pinImageView.centerYAnchor)
        ])
    }
    
    // Current Weather Image
    private func createCurrentWeatherImageView() {
        self.addSubview(weatherImageView)
        NSLayoutConstraint.activate([
            weatherImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40),
            weatherImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            weatherImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
    }
    
    // Current Weather Status
    private func createCurrentWeatherStatusLabel() {
        self.addSubview(weatherStatusLabel)
        NSLayoutConstraint.activate([
            weatherStatusLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -10),
            weatherStatusLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor)
        ])
    }
    
    // Current Temp
    private func createCurrentTempLabel() {
        self.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            tempLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
    }
    
    // Current Wind Items
    func createCurrentWindItems() {
        self.addSubview(windIconImageView)
        NSLayoutConstraint.activate([
            windIconImageView.widthAnchor.constraint(equalToConstant: 40),
            windIconImageView.heightAnchor.constraint(equalToConstant: 20),
            windIconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            windIconImageView.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 10)
        ])
        
        self.addSubview(windLabel)
        NSLayoutConstraint.activate([
            windLabel.trailingAnchor.constraint(equalTo: windIconImageView.leadingAnchor, constant: -10),
            windLabel.centerYAnchor.constraint(equalTo: windIconImageView.centerYAnchor)
        ])
    }
    
    // Main Progress View
    private func createProgressView() {
        self.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalTo: self.widthAnchor),
            progressView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    // Image Load Progress View
    private func createImageProgressView() {
        weatherImageView.addSubview(iconProgressView)
        NSLayoutConstraint.activate([
            iconProgressView.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor),
            iconProgressView.heightAnchor.constraint(equalTo: weatherImageView.heightAnchor)
        ])
    }
    
    // Update Weather Detail
    public func updateWeatherDetail(data: WeatherDataModel) {
        locationLabel.text = "\(data.name ?? "") - \(data.sys?.country ?? "")"
        weatherTemp = data.main?.temp
        updateWeatherTemp()
        
        // Progress stop animating
        progressView.stopAnimating()
        progressView.backgroundColor = .clear
        
        windLabel.text = "\(Int(data.wind?.speed ?? 0.0)) km/s"
        
        // Weather description text
        lazy var weatherDescription: String = ""
        weatherStatusLabel.text = weatherDescription.capitalizeFirstLetter(data.weather?.first?.main ?? "")
        
        // Weather status icon request
        lazy var iconCode: String = data.weather?[0].icon ?? ""
        lazy var iconURL: String = "\(Constants.shared.iconBaseURL)\(iconCode)@4x.png"
        
        weatherImageView.kf.setImage(with: URL(string: iconURL), completionHandler: {[weak self] result in
            switch result { 
            case .success(let value):
                self?.iconProgressView.stopAnimating()
                self?.iconProgressView.backgroundColor = .clear
                self?.weatherImageView.image = value.image
            case .failure(_): break
            }
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.tempLabel.alpha = 1
            self.weatherImageView.alpha = 1
            self.weatherStatusLabel.alpha = 1
            self.locationLabel.alpha = 1
            self.pinImageView.alpha = 1
            self.windLabel.alpha = 1
            self.windIconImageView.alpha = 1
        })
    }
    
    // Update Weather Temp
    func updateWeatherTemp() {
        lazy var tempType = WeatherManager.shared.getWeatherTempType()
        var convertValue: String = ""
        switch tempType {
        case .CELCIUS:
            let value = Double(convertValue.kelvinToCelcius(temp: self.weatherTemp ?? 0))
            self.tempLabel.text = "\(Int(value))°C"
        case .KELVIN:
            self.tempLabel.text = "\(Int(self.weatherTemp ?? 0))K"
        case .DEFAULT:
            self.tempLabel.text = "\(Int(self.weatherTemp ?? 0))K"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
