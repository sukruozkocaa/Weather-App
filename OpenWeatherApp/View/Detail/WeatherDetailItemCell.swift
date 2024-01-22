//
//  WeatherDetailItemCell.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 19.01.2024.
//

import UIKit
import Kingfisher

class WeatherDetailItemCell: UITableViewCell {

    // Views
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherIconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private lazy var timeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "timer")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var windIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wind")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Override Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    // Initialize
    func initialize() {
        backgroundColor = .clear
        createTimeItems()
        createWeatherItems()
        createWindItems()
    }
    
    // Create Time Items
    func createTimeItems() {
        self.addSubview(timeIcon)
        NSLayoutConstraint.activate([
            timeIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            timeIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            timeIcon.widthAnchor.constraint(equalToConstant: 30),
            timeIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        self.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 10)
        ])
    }
    
    // Create Weather Items
    func createWeatherItems() {
        self.addSubview(weatherLabel)
        NSLayoutConstraint.activate([
            weatherLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        self.addSubview(weatherIconImageView)
        NSLayoutConstraint.activate([
            weatherIconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            weatherIconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 50),
            weatherIconImageView.trailingAnchor.constraint(equalTo: weatherLabel.leadingAnchor, constant: -5),
            weatherIconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    // Create Wind Items
    func createWindItems() {
        self.addSubview(windLabel)
        NSLayoutConstraint.activate([
            windLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            windLabel.trailingAnchor.constraint(equalTo: weatherIconImageView.leadingAnchor, constant: -20)
        ])
        
        self.addSubview(windIcon)
        NSLayoutConstraint.activate([
            windIcon.topAnchor.constraint(equalTo: timeIcon.topAnchor),
            windIcon.widthAnchor.constraint(equalToConstant: 30),
            windIcon.bottomAnchor.constraint(equalTo: timeIcon.bottomAnchor),
            windIcon.trailingAnchor.constraint(equalTo: windLabel.leadingAnchor,constant: -5)
        ])
    }
    
    // Bind
    func bind(data: WeatherForecast) {
        // Time from data
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = inputFormatter.date(from: data.dtTxt ?? "") {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            let timeString = outputFormatter.string(from: date)
            timeLabel.text = timeString
        }
        
        // Wind label
        windLabel.text = "\(Int(data.wind?.speed ?? 0)) km/h"

        // Temp type
        lazy var tempType = WeatherManager.shared.getWeatherTempType()
        switch tempType {
        case .CELCIUS:
            let celcius = Int((data.main?.temp ?? 0) - (273.15))
            weatherLabel.text = "\(celcius)°C"
        case .KELVIN:
            weatherLabel.text = "\(Int(data.main?.temp ?? 0))K"
        case .DEFAULT:
            weatherLabel.text = "\(Int(data.main?.temp ?? 0))K"
        }
        
        // Icon
        lazy var iconCode: String = data.weather?[0].icon ?? ""
        lazy var iconURL: String = "\(Constants.shared.iconBaseURL)\(iconCode)@4x.png"
        weatherIconImageView.kf.setImage(with: URL(string: iconURL))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
