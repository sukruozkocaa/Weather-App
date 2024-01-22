//
//  MainContentView.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 19.01.2024.
//

import Foundation
import UIKit

enum WeatherValueTypes: String {
    case CELCIUS, KELVIN, DEFAULT
}

class MainContentView: UIView {
    
    // Views
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Kelvin","Celcius"])
        segmentedControl.tintColor = Constants.shared.segmentedTintColor
        segmentedControl.addTarget(self, action: #selector(changeValueType), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = Constants.shared.segmentedSelectedColor
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var weatherNowView: WeatherNowView = {
        let view = WeatherNowView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var weatherForecastView: WeatherForecastView = {
        let weatherForecastView = WeatherForecastView()
        weatherForecastView.delegate = self
        weatherForecastView.backgroundColor = .clear
        weatherForecastView.translatesAutoresizingMaskIntoConstraints = false
        return weatherForecastView
    }()
        
    // Variables
    weak var delegate: WeatherDetailDelegate?
    
    // Override init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    // Initialize
    func initialize() {
        createSegmentedControl()
        createCurrentWeatherView()
        createLongTermWeatherView()
    }
    
    // Create Top Segmented Control
    func createSegmentedControl() {
        let tempType: WeatherValueTypes = WeatherManager.shared.getWeatherTempType()
        segmentedControl.selectedSegmentIndex = tempType == .CELCIUS ? 1 : 0
        self.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20)
        ])
    }
    
    // Create current weather view
    func createCurrentWeatherView() {
        self.addSubview(weatherNowView)
        NSLayoutConstraint.activate([
            weatherNowView.heightAnchor.constraint(equalToConstant: 100),
            weatherNowView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            weatherNowView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            weatherNowView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20)
        ])
    }

    // Create long term weather view
    func createLongTermWeatherView() {
        self.addSubview(weatherForecastView)
        NSLayoutConstraint.activate([
            weatherForecastView.topAnchor.constraint(equalTo: weatherNowView.bottomAnchor, constant: 50),
            weatherForecastView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            weatherForecastView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            weatherForecastView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // Current location weather data update
    func updateCurrentWeatherView(data: WeatherDataModel) {
        self.weatherNowView.updateWeatherDetail(data: data)
    }
    
    // Long term weather data update
    func updateLongTermWeatherView(filterData: [WeatherForecast]?, data: WeatherForecastDataModel) {
        self.weatherForecastView.updateWeathersDetail(data: filterData)
    }
    
    // Change Weather Temp Type
    @objc func changeValueType(_ sender: UISegmentedControl) {
        // Feedback
        UIImpactFeedbackGenerator().impactOccurred()
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.setValue(WeatherValueTypes.KELVIN.rawValue, forKey: UserDefaults.Keys.weatherValueTypes)
            weatherNowView.updateWeatherTemp()
        case 1:
            UserDefaults.standard.setValue(WeatherValueTypes.CELCIUS.rawValue, forKey: UserDefaults.Keys.weatherValueTypes)
            weatherNowView.updateWeatherTemp()
        default: break
        }
        
        weatherForecastView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainContentView: WeatherDetailDelegate {
    func showWeatherDetail(forDay: String) {
        delegate?.showWeatherDetail(forDay: forDay)
    }
}
