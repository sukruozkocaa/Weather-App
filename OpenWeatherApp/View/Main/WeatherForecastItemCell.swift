//
//  WeatherForecastItemCell.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 17.01.2024.
//

import UIKit
import Kingfisher

class WeatherForecastItemCell: UICollectionViewCell {
    
    // Views
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 60, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "wind", withConfiguration: UIImage.SymbolConfiguration(pointSize: 1))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Override Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
   
    // Initialize
    private func initialize() {
        backgroundColor = .clear
        createWeatherIconImageView()
        createStatusLabel()
        createDateLabel()
        createTempLabel()
        createWindItems()
    }
    
    // Create Icon ImageView
    private func createWeatherIconImageView() {
        self.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 150),
            iconImageView.heightAnchor.constraint(equalToConstant: 150),
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    // Create Status Label
    private func createStatusLabel() {
        self.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            statusLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 0)
        ])
    }
    
    // Create Date Label
    private func createDateLabel() {
        self.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    // Create Date Label
    private func createTempLabel() {
        self.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            tempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    // Create Wind Items
    private func createWindItems() {
        self.addSubview(windIconImageView)
        NSLayoutConstraint.activate([
            windIconImageView.widthAnchor.constraint(equalToConstant: 50),
            windIconImageView.heightAnchor.constraint(equalToConstant: 50),
            windIconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            windIconImageView.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20)
        ])
        
        self.addSubview(windLabel)
        NSLayoutConstraint.activate([
            windLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            windLabel.topAnchor.constraint(equalTo: windIconImageView.bottomAnchor, constant: 10)
        ])
    }
    
    // Bind Cell
    func bindCell(data: WeatherForecast) {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = inputFormatter.date(from: data.dtTxt ?? "") {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            let outputDateString = outputFormatter.string(from: date)
            dateLabel.text = outputDateString
        }
    
        windLabel.text = "\(Int(data.wind?.speed ?? 0.0)) km/h"
        statusLabel.text = data.weather?[0].main
        
        // Weather Temp
        let tempType = WeatherManager.shared.getWeatherTempType()
        if tempType == .CELCIUS {
            let celcius = Int((data.main?.temp ?? 0) - (273.15))
            tempLabel.text = "\(celcius)°C"
        } else {
            tempLabel.text = "\(Int(data.main?.temp ?? 0))K"
        }
              
        // Weather Icon
        var iconCode: String = data.weather?[0].icon ?? ""
        var iconURL: String = "\(Constants.shared.iconBaseURL)\(iconCode)@4x.png"
        iconImageView.kf.setImage(with: URL(string: iconURL))
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
