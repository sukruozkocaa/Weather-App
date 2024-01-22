//
//  MainViewController.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 17.01.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    // Views
    private lazy var mainContentView: MainContentView = {
        let contentView = MainContentView(frame: self.view.frame)
        contentView.backgroundColor = .white
        contentView.delegate = self
        view.addSubview(contentView)
        return contentView
    }()
    
    // Variables
    private lazy var currentWeeklyForecastData: WeatherForecastDataModel? = nil
    private let weatherViewModel = WeatherViewModel()
    
    // Fetch data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Navigation bar title set
        let titleLabel = UILabel()
        titleLabel.text = "Weather"
        titleLabel.textColor = UIColor.black
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        navigationItem.titleView = titleLabel
        
        // Fetch current day weather data
        fetchCurrentWeatherData()
    }
    
    // Fetch current weather data
    func fetchCurrentWeatherData() {
        // Main thread call to current weather data
        self.weatherViewModel.getTodayWeatherData(completion: { weatherData in
            self.mainContentView.updateCurrentWeatherView(data: weatherData)
            
            // Main thread call to Long term weather
            self.weatherViewModel.getWeeklyForecastData { [weak self] filterData, weeklyForecastData in
                guard let self = self else { return }
                if let weeklyForecastData = weeklyForecastData {
                    self.currentWeeklyForecastData = weeklyForecastData
                    self.mainContentView.updateLongTermWeatherView(filterData: filterData, data: weeklyForecastData)
                }
            }
        })
    }
}

extension MainViewController: WeatherDetailDelegate {
    func showWeatherDetail(forDay: String) {
        let detailVC = DetailViewController()
        detailVC.dayToFilter = forDay
        detailVC.weatherData = self.currentWeeklyForecastData
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
